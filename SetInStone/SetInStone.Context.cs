﻿//------------------------------------------------------------------------------
// <auto-generated>
//    This code was generated from a template.
//
//    Manual changes to this file may cause unexpected behavior in your application.
//    Manual changes to this file will be overwritten if the code is regenerated.
// </auto-generated>
//------------------------------------------------------------------------------

namespace SetInStone
{
    using System;
    using System.Data.Entity;
    using System.Data.Entity.Infrastructure;
    
    public partial class SetInStoneEntities : DbContext
    {
        public SetInStoneEntities()
            : base("name=SetInStoneEntities")
        {
        }
    
        protected override void OnModelCreating(DbModelBuilder modelBuilder)
        {
            throw new UnintentionalCodeFirstException();
        }
    
        public DbSet<Slab_Table> Slab_Table { get; set; }
        public DbSet<Stone_Type> Stone_Types { get; set; }
        public DbSet<Product> Products { get; set; }
    }
}
