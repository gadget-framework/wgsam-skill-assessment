; Gadget version 2.3.9 running on SLU-RSERVER02 Fri Apr 14 17:48:59 2023
; Simulated Annealing algorithm ran for 0 function evaluations
; and stopped when the likelihood value was 10005.332
; because the convergence criteria were met
; Hooke & Jeeves algorithm ran for 0 function evaluations
; and stopped when the likelihood value was 10005.332
; because the convergence criteria were met
; -- data --
switch	value		lower	upper	optimise
had.Linf	   89.844348	   71.88    107.8        0
had.k	   17.985485	     0.1      100        0
had.walpha	       0.012	   0.001      0.1        0
had.wbeta	        2.95	       2        4        0
had.bbin	 0.010000364	    0.01       50        0
had.init.scalar	      0.0001	   1e-05    1e+06        0
had.recl	   43.111849	   8.622    86.22        0
had.rec.scalar	       10000	    1000    1e+07        0
had.rec.40	   2.5947085	     0.1      100        0
had.rec.sd	   2.8693131	  0.6376    6.376        0
had.rec.41	   2.7414595	     0.1      100        0
had.rec.42	   5.0439697	     0.1      100        0
had.rec.43	   4.2312702	     0.1      100        0
had.rec.44	   3.5137185	     0.1      100        0
had.rec.45	   4.6635283	     0.1      100        0
had.rec.46	   1.6875789	     0.1      100        0
had.rec.47	   4.7321137	     0.1      100        0
had.rec.48	   2.2181945	     0.1      100        0
had.rec.49	   3.3738945	     0.1      100        0
had.rec.50	   1.9952157	     0.1      100        0
had.rec.51	   6.1925194	     0.1      100        0
had.rec.52	   5.3373675	     0.1      100        0
had.rec.53	   1.8899539	     0.1      100        0
had.rec.54	   1.8726217	     0.1      100        0
had.rec.55	   1.5184376	     0.1      100        0
had.rec.56	  0.87195962	     0.1      100        0
had.rec.57	   1.1206337	     0.1      100        0
had.rec.58	   1.0777611	     0.1      100        0
had.rec.59	    1.426241	     0.1      100        0
had.rec.60	  0.63603875	     0.1      100        0
had.rec.61	  0.78804307	     0.1      100        0
had.rec.62	  0.64154224	     0.1      100        0
had.rec.63	   0.5905635	     0.1      100        0
had.rec.64	  0.47309987	     0.1      100        0
had.rec.65	  0.75134935	     0.1      100        0
had.rec.66	   3.6973261	     0.1      100        0
had.rec.67	   12.929801	     0.1      100        0
had.rec.68	   7.5239452	     0.1      100        0
had.rec.69	   3.9794066	     0.1      100        0
had.rec.70	   2.3947895	     0.1      100        0
had.rec.71	   1.9942286	     0.1      100        0
had.rec.72	   1.1383678	     0.1      100        0
had.rec.73	   1.5188766	     0.1      100        0
had.rec.74	  0.74806409	     0.1      100        0
had.rec.75	   1.2016808	     0.1      100        0
had.rec.76	  0.81770791	     0.1      100        0
had.rec.77	   1.3452981	     0.1      100        0
had.rec.78	   1.4316093	     0.1      100        0
had.rec.79	   4.7801861	     0.1      100        0
had.rec.80	   10.190677	     0.1      100        0
had.rec.81	   3.9178658	     0.1      100        0
had.rec.82	   5.6983367	     0.1      100        0
had.rec.83	   3.2521579	     0.1      100        0
had.rec.84	   3.3904038	     0.1      100        0
had.rec.85	   6.8425902	     0.1      100        0
had.rec.86	   7.2755665	     0.1      100        0
had.rec.87	   3.9504757	     0.1      100        0
had.rec.88	   3.7285442	     0.1      100        0
had.rec.89	   4.5871472	     0.1      100        0
had.rec.90	   2.6720422	     0.1      100        0
had.rec.91	   3.1189004	     0.1      100        0
had.rec.92	   1.9431409	     0.1      100        0
had.rec.93	   2.7488989	     0.1      100        0
had.rec.94	   2.2507934	     0.1      100        0
had.rec.95	   2.4015756	     0.1      100        0
had.rec.96	   9.8282679	     0.1      100        0
had.rec.97	    9.246173	     0.1      100        0
had.rec.98	   3.3451853	     0.1      100        0
had.rec.99	   4.9485151	     0.1      100        0
had.rec.100	   3.2596828	     0.1      100        0
had.rec.101	   3.1480014	     0.1      100        0
had.rec.102	   2.3725016	     0.1      100        0
had.rec.103	   1.8788429	     0.1      100        0
had.rec.104	   2.1787515	     0.1      100        0
had.rec.105	   1.7306138	     0.1      100        0
had.rec.106	   1.5407801	     0.1      100        0
had.rec.107	    2.002917	     0.1      100        0
had.rec.108	   1.1415342	     0.1      100        0
had.rec.109	   1.3853375	     0.1      100        0
had.rec.110	  0.86303387	     0.1      100        0
had.rec.111	   1.2822968	     0.1      100        0
had.rec.112	  0.88745248	     0.1      100        0
had.rec.113	   1.0307062	     0.1      100        0
had.rec.114	  0.85778713	     0.1      100        0
had.rec.115	  0.78692464	     0.1      100        0
had.rec.116	  0.73368931	     0.1      100        0
had.rec.117	  0.77447692	     0.1      100        0
had.rec.118	  0.92915271	     0.1      100        0
had.rec.119	  0.93722381	     0.1      100        0
had.rec.120	   1.9184509	     0.1      100        0
had.surQ1.alpha	  0.10000608	     0.1        2        0
had.surQ1.l50	   71.849524	      22      128        0
had.surQ3.alpha	  0.10000441	     0.1        2        0
had.surQ3.l50	   63.191726	      12      123        0
had.com.alpha	  0.26277131	     0.1        3        0
had.com.l50	    66.15371	      44      105        0
