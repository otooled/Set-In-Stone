//------------------------------------------------------------------------------
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
    using System.Collections.Generic;
    
    public partial class Slab
    {
        public byte SlabID { get; set; }
        public Nullable<byte> StoneId { get; set; }
        public Nullable<decimal> Length { get; set; }
        public Nullable<decimal> Width { get; set; }
        public Nullable<decimal> Depth { get; set; }
        public Nullable<decimal> Cost { get; set; }
        public Nullable<decimal> CutCostPerSqMtr { get; set; }
    
        public virtual Stone_Type Stone_Type { get; set; }
    }
}
