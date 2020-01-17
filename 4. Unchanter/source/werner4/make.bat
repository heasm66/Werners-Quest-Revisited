..\..\..\..\..\..\Source\ZIL\ZILF\zilf-0.9.0-win-x64\bin\Zilf.exe -w werner4.zil
..\..\..\..\..\..\Source\ZIL\ZILF\zilf-0.9.0-win-x64\bin\Zapf.exe -ab werner4.zap > werner4_freq.xzap
del werner4_freq.zap
..\..\..\..\..\..\Source\ZIL\ZILF\zilf-0.9.0-win-x64\bin\Zapf.exe werner4.zap
del /F /Q ..\..\bin\*.*
del /F /Q ..\..\zapf\*.*
move *.zap ..\..\zapf\
move *.xzap ..\..\zapf\
move *.dbg ..\..\zapf\
move *.z5 ..\..\bin\
