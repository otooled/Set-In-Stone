﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace SetInStone.CalcClasses
{
    public static class Cost
    {
        private static SIS2 db = new SIS2();
       static void Dispose(bool disposing)
        {
            db.Dispose();
        }


       public static void CalcStraight(string sType, float slWidth, float slHeight, float slLength)
        {
            List<Slab> slabs = db.Slabs.ToList();

            var heightOk = slabs.Where(a => a.Thickness > slHeight);
            var pickSlab = heightOk.OrderBy(a => a.Thickness).Take(1);

           

        }
        public static float CalcCost(string sType, float slWidth, float slHeight, float slLength)
        {
            float cost = 0;

            var volume = slHeight*slWidth*slLength;

            var stoneCost = db.Stones.Where(a => a.StoneType == sType).FirstOrDefault();//Stone.Where(a => a. > slHeight);
            cost = volume*(float)stoneCost.CostPerCube;

            return cost;
        }
        ////Pyramid surface area - formula A = lw+l.√(w2/2)²+h²+w.√(l/2)²+h²

        ////step one of formula (L)(W)+(L)
        //decimal fPart1 = customerSlabArea + slabLength;

        ////step two of formula (w/2)²+h²+w - not getting the square root yet
        //decimal fPart2 = (slabWidth / 2) * (slabWidth / 2) + (pyramidHeight * pyramidHeight) + slabWidth;

        ////step three of formula (l/2)²+h² - not getting the square root yet

        //decimal fPart3 = (slabLength/2)*(slabLength/2) + (pyramidHeight*pyramidHeight);

        ////step four of formula - get square root of part 2 and part 3

        //decimal sqrtOfPart2 = (Decimal)Math.Sqrt(Convert.ToDouble(fPart2));
        //decimal sqrtOfPart3 = (Decimal)Math.Sqrt(Convert.ToDouble(fPart3));

        //decimal surfaceAreaOfPyramid = fPart1*sqrtOfPart2*sqrtOfPart3;
        public static float PyramidCutCost(string sType, float slWidth, float slHeight, float pyrHeight, float slLength)
        {
            float pyramidCost;

            float baseArea = slLength*slWidth;
            ////step one of formula (L)(W)+(L)
            float fPart1 = baseArea + slLength;

            //step two of formula (w/2)²+h²+w - not getting the square root yet
            float fPart2 = (slWidth/2)*(slWidth/2) + (pyrHeight*pyrHeight) + slWidth;

            //step three of formula (l/2)²+h² - not getting the square root yet

            float fPart3 = (slLength/2)*(slLength/2) + (pyrHeight*pyrHeight);

            //step four of formula - get square root of part 2 and part 3

            float sqrtOfPart2 = (float) Math.Sqrt(Convert.ToDouble(fPart2));
            float sqrtOfPart3 = (float) Math.Sqrt(Convert.ToDouble(fPart3));
            var surfaceArea = fPart1 * sqrtOfPart2 * sqrtOfPart3;
            return surfaceArea;
        }
    }
}