hints.addMode ("g", "Download from Github: ",

     function(elem) {
         liberator.echomsg("Downloaded from Github: "+elem.href),
         liberator.execute("silent !gitfile '"+ elem.href+"'")
     },
     function () "// a"
);
