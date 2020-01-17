..\..\..\..\..\..\Source\ZIL\ZILF\zilf-0.9.0-win-x64\bin\Zilf.exe -w werner1.zil
..\..\..\..\..\..\Source\ZIL\ZILF\zilf-0.9.0-win-x64\bin\Zapf.exe -ab werner1.zap > werner1_freq.xzap
del werner1_freq.zap
..\..\..\..\..\..\Source\ZIL\ZILF\zilf-0.9.0-win-x64\bin\Zapf.exe werner1.zap
del /F /Q ..\..\bin\*.*
del /F /Q ..\..\zapf\*.*
move *.zap ..\..\zapf\
move *.xzap ..\..\zapf\
move *.dbg ..\..\zapf\
move *.z5 ..\..\bin\
