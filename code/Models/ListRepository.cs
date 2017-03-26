using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace OutOfEggs.Models
{
    public class ListRepository
    {
        private OutOfEggsDataContext db = new OutOfEggsDataContext();

        //
        // Query Methods

        public List GetById(long id)
        {
            return db.Lists.Single(l => l.ListId == id);
        }

        public IQueryable<List> GetByUserId(string userId)
        {
            return from l in db.Lists
                   where l.UserId.ToString() == userId
                   orderby l.ListName ascending
                   select l;
        }

        //
        // Insert/Update/Delete Methods

        public void Insert(List list)
        {
            db.Lists.InsertOnSubmit(list);
        }

        //Make an exact duplicate of a list (all sections & items in order)
        //Return new list id? or list object?
        //TODO public long Copy(long sourceListId)

        public void Delete(List list)
        {
            //Sections deleted via SQL cascade delete
            db.Sections.DeleteAllOnSubmit(list.Sections);
            db.Lists.DeleteOnSubmit(list);
        }

        //
        // Persistance

        public void Save()
        {
            db.SubmitChanges();
        }
    }
}
