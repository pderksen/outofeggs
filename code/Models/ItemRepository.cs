using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace OutOfEggs.Models
{
    public class ItemRepository
    {
        OutOfEggsDataContext db = new OutOfEggsDataContext();

        //
        // Query Methods

        public Item GetById(long id)
        {
            return db.Items.Single(i => i.ItemId == id);
        }

        public IQueryable<Item> GetBySectionId(long sectionId)
        {
            return from i in db.Items
                   where i.SectionId == sectionId
                   orderby i.SortOrder ascending
                   select i;
        }

        //
        // Insert/Update/Delete Methods

        public void Insert(Item item)
        {
            item.SortOrder = GetNextItemSortOrderValueBySectionId(item.SectionId);
            db.Items.InsertOnSubmit(item);
        }

        public void Delete(Item item)
        {
            db.Items.DeleteOnSubmit(item);
        }

        //Pass a string array of item ids in a section and save their sort order in the order they're passed in.
        //TODO move to controller?
        public void UpdateSortOrder(long sectionId, string[] itemIds)
        {
            for (int i = 0; i < itemIds.Length; i++)
            {
                Item item = GetById(long.Parse(itemIds[i]));
                item.SectionId = sectionId;
                item.SortOrder = i + 1;
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

        //Get item sort order value that's one higher than existing highest value.
        private int GetNextItemSortOrderValueBySectionId(long sectionId)
        {
            //Max value is null if no items yet
            int? highestSortValue = (from i in db.Items
                                     where i.SectionId == sectionId
                                     select (int?)i.SortOrder).Max();

            return (highestSortValue ?? 0) + 1;
        }
    }
}
