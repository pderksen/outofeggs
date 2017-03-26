using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace OutOfEggs.Models
{
    public class SectionRepository
    {
        OutOfEggsDataContext db = new OutOfEggsDataContext();

        //
        // Query Methods

        public Section GetById(long id)
        {
            //Errors out when trying to retrieve section that doesn't exist.
            //Used to get when section deleted wasn't removed from DOM, then passed here by sortable().
            return db.Sections.Single(s => s.SectionId == id);
            //return db.Sections.SingleOrDefault(s => s.SectionId == id);
        }

        //Get item sort order value that's one higher than existing highest value.
        public int GetNextSectionSortOrderValueByListIdColumnNum(long listId, int colNum)
        {
            //Max value is null if no items yet
            int? highestSortValue = (from s in db.Sections
                                     where (s.ListId == listId) && (s.ColumnNum == colNum)
                                     select (int?)s.SortOrder).Max();

            return (highestSortValue ?? 0) + 1;
        }

        //
        // Insert/Update/Delete Methods

        public void Insert(Section sec)
        {
            db.Sections.InsertOnSubmit(sec);
        }

        //Pass a string array of section names to insert for a list
        //Used mainly on create new list screen
        //Take number of sections and divide evently between columns
        //TODO move to controller?
        public void InsertMultipleSections(long listId, string[] sectionNames)
        {
            int maxSectionsInColumn = (sectionNames.Length / 4);

            //If remainder/modulus add one
            int sectionsModulus = (sectionNames.Length % 4);
            if (sectionsModulus > 0)
            {
                maxSectionsInColumn += 1;
            }

            Section sec;

            int currentColumnNum = 1;

            for (int i = 0; i < sectionNames.Length; i++)
            {
                sec = new Section();
                sec.ListId = listId;

                //Move to next column if we hit limit for column
                //Subtract one if multiplying would put over total sections
                if ((i + 1) > (currentColumnNum * maxSectionsInColumn))
                {
                    currentColumnNum += 1;
                }

                sec.ColumnNum = currentColumnNum;
                sec.SectionName = sectionNames[i];

                //Setting sort order to same as section # works fine
                sec.SortOrder = i;

                //Insert into repository ready for save
                Insert(sec);
            }
        }

        public void Delete(Section sec)
        {
            //Items deleted via SQL cascade delete
            db.Sections.DeleteOnSubmit(sec);
        }

        //Delete all child Item records without deleting section record itself
        public void DeleteChildItems(Section sec)
        {
            db.Items.DeleteAllOnSubmit(sec.Items);
        }

        //Pass a string array of section ids in a column and save their sort order in the order they're passed in.
        //TODO move to controller?
        public void UpdateSortOrder(int columnNum, string[] sectionIds)
        {
            for (int i = 0; i < sectionIds.Length; i++)
            {
                //On error go to the next section to sort.
                try
                {
                    Section sec = GetById(long.Parse(sectionIds[i]));
                    sec.ColumnNum = columnNum;
                    sec.SortOrder = i + 1;
                }
                catch
                {
                    //TODO log error
                }
            }
        }

        //
        // Persistance

        public void Save()
        {
            db.SubmitChanges();
        }

        //
        // Private Methods
    }
}
