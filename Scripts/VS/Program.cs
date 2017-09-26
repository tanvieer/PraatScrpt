using Excel;
using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ReadWriteCSV
{
    class Program
    {
        enum reason
        {
            hu,
            bu,
            bp,
            dc,
            ti
        };

        enum gender
        {
            f,
            m
        }

  
        string age1 = "04";
        string age2 = "48";
        string age3 = "26";
        string age4 = "72";
        string age5 = "22";

        public static int count = 0;

        static void Main(string[] args)
        {
            string head = "fileName,pitch_med,pitch_med,pitch_SD,pitch_max,pitch_min,jitter_local,jitter_local_abs,jitter_rap,jitter_ppq5,jitter_ddp,shimmer_local,shimmer_local_dB,shimmer_apq3,shimmer_apq5,shimmer_apq11,shimmer_dda,voicing_fractunvoicedframes,voicing_numbreaks,voicing_degbreaks,recordedTime,gender,age,class";

            
            using (StreamWriter w = new StreamWriter(@"C:\Users\Tanvir\Desktop\grouping\write2.csv"))
            {
                w.WriteLine(head);
                foreach (var worksheet in Workbook.Worksheets(@"C:\Users\Tanvir\Desktop\vs\read.xlsx")) {
                    foreach (var row in worksheet.Rows)  {
                        

                        try
                        {
                            string _reason = row.Cells[22].Text.ToString();
                            string _age = row.Cells[21].Text.ToString();
                            string _gender = row.Cells[20].Text.ToString();

                            if (_age.Length < 2) _age = "0" + _age;

                            string _filename = row.Cells[0] != null ? row.Cells[0].Text.ToString() : null;

                           // Console.WriteLine(_filename + "-1.7-" + _gender + "-" + _age + "-" + _reason + ".wav = "+count);

                            if (_filename != null)
                            {

                                 if(_reason == "dk") 
                                moveFile(_filename + "-1.0-" + _gender + "-" + _age + "-" + _reason + ".wav");
                               // Console.WriteLine(_filename + "-1.1-" + _gender + "-" + _age + "-" + _reason + ".wav = " + count); // 1.0 1.1 1.7
                            }


                        } catch(Exception e)
                        {
                            //Console.WriteLine(e.Data);
                        }



                            //if (true)
                            //{
                            //    WriteSpace(w);
                            //}
                            //if (true)
                            //{
                            //    AddRow(w, row);
                            //}
                    }
                }
                Console.ReadKey();
              //  w.Flush();
            }


        }


        public static void WriteSpace(StreamWriter w)
        {
            w.WriteLine();
        }

        public static void AddRow(StreamWriter w , Row row )
        {
            foreach (var cell in row.Cells) w.Write(cell.Value.ToString() + ",");
            w.WriteLine();
        }



        public static void moveFile(string fileName)
        {
            //string sourcePath = "C:\\Users\\Tanvir\\Desktop\\vs\\backupall\\";
            //string targetPath = "C:\\Users\\Tanvir\\Desktop\\vs\\Nothu\\";

            string sourcePath = "C:\\Users\\Tanvir\\Desktop\\vs\\backupall\\";
            string targetPath = "C:\\Users\\Tanvir\\Desktop\\vs\\DK\\";

            string sourceFile = System.IO.Path.Combine(sourcePath, fileName);
            string destFile = System.IO.Path.Combine(targetPath, fileName);

            if (!System.IO.Directory.Exists(targetPath))
            {
                System.IO.Directory.CreateDirectory(targetPath);
            }
            System.IO.File.Copy(sourceFile, destFile, true);
           System.IO.File.Delete(sourceFile);
            count++;

            Console.WriteLine("Counter ========== " + count);
            Console.WriteLine("filename ========== " + fileName);
        }
    }
}











/*
 
     
     
     
     
     
     using Excel;
using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ReadWriteCSV
{
    class Program
    {
        enum reason
        {
            hu,
            bu,
            bp,
            dc,
            ti
        };

        enum gender
        {
            f,
            m
        }

  
        string age1 = "04";
        string age2 = "48";
        string age3 = "26";
        string age4 = "72";
        string age5 = "22";

        static void Main(string[] args)
        {
           // string head = "fileName,pitch_med,pitch_med,pitch_SD,pitch_max,pitch_min,jitter_local,jitter_local_abs,jitter_rap,jitter_ppq5,jitter_ddp,shimmer_local,shimmer_local_dB,shimmer_apq3,shimmer_apq5,shimmer_apq11,shimmer_dda,voicing_fractunvoicedframes,voicing_numbreaks,voicing_degbreaks,recordedTime,gender,age,class";

           // using (StreamWriter w = new StreamWriter(@"C:\Users\Tanvir\Desktop\grouping\write2.csv"))
         //   {
              //  w.WriteLine(head);
                foreach (var worksheet in Workbook.Worksheets(@"C:\Users\Tanvir\Desktop\vs\read.xlsx")) {
                    foreach (var row in worksheet.Rows)  {
                    //string _reason = row.Cells[23].Text.ToString();
                    //string _age = row.Cells[22].Text.ToString();
                    //string _gender = row.Cells[21].Text.ToString();

                    //if (true)
                    //{
                    //    WriteSpace(w);
                    //}
                    //if (true)
                    //{
                    //    AddRow(w, row);
                    //}

                    Console.WriteLine(row.Cells[0].Text.ToString());




                    }
                }
                Console.ReadKey();
              //  w.Flush();
          //  }


        }


        public static void WriteSpace(StreamWriter w)
        {
            w.WriteLine();
        }

        public static void AddRow(StreamWriter w , Row row )
        {
            foreach (var cell in row.Cells) w.Write(cell.Value.ToString() + ",");
            w.WriteLine();
        }


        //public static void moveFile(string fileName)
        //{
        //    string sourcePath = "C:\\Users\\Tanvir\\Desktop\\vs\\all\\";
        //    string targetPath = "C:\\Users\\Tanvir\\Desktop\\vs\\clean\\";
        //    string sourceFile = System.IO.Path.Combine(sourcePath, fileName);
        //    string destFile = System.IO.Path.Combine(targetPath, fileName);

        //    if (!System.IO.Directory.Exists(targetPath))
        //    {
        //        System.IO.Directory.CreateDirectory(targetPath);
        //    }
        //    System.IO.File.Copy(sourceFile, destFile, true);
        //}
    }
}

     
     
     
     
     
     
     */
