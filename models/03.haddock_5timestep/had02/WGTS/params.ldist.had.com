; Gadget version 2.3.9 running on SLU-RSERVER02 Tue Sep 26 00:30:57 2023
; Simulated Annealing algorithm ran for 100001 function evaluations
; and stopped when the likelihood value was 373.16127
; because the maximum number of function evaluations was reached
; Hooke & Jeeves algorithm ran for 1793 function evaluations
; and stopped when the likelihood value was 340.57053
; because the convergence criteria were met
; -- data --
switch	value		lower	upper	optimise
had.Linf	   90.956718	   68.98    103.5        1
had.k	   12.399847	   1.757    87.86        1
had.walpha	       0.012	  0.0012     0.12        0
had.wbeta	        2.95	       2        4        0
had.bbin	   1.2558063	    0.01       50        1
had.init.scalar	      0.0001	   1e-05    1e+06        0
had.recl	   47.239321	      20       50        1
had.rec.scalar	       10000	    1000    1e+07        0
had.rec.40	   1.7110212	     0.1      100        1
had.rec.sd	   1.4188565	  0.6376    6.376        1
had.rec.41	   4.2869096	     0.1      100        1
had.rec.42	   16.555545	     0.1      100        1
had.rec.43	   26.564959	     0.1      100        1
had.rec.44	  0.12842875	     0.1      100        1
had.rec.45	   8.7835966	     0.1      100        1
had.rec.46	   8.5983234	     0.1      100        1
had.rec.47	  0.26140361	     0.1      100        1
had.rec.48	   15.661264	     0.1      100        1
had.rec.49	    2.664249	     0.1      100        1
had.rec.50	    4.657369	     0.1      100        1
had.rec.51	   1.2559967	     0.1      100        1
had.rec.52	    15.00866	     0.1      100        1
had.rec.53	   9.7662521	     0.1      100        1
had.rec.54	    3.893886	     0.1      100        1
had.rec.55	  0.89520509	     0.1      100        1
had.rec.56	  0.10005096	     0.1      100        1
had.rec.57	   5.9665589	     0.1      100        1
had.rec.58	   3.6756839	     0.1      100        1
had.rec.59	   1.4921557	     0.1      100        1
had.rec.60	   12.525952	     0.1      100        1
had.rec.61	   6.4119963	     0.1      100        1
had.rec.62	  0.46049256	     0.1      100        1
had.rec.63	   1.7293823	     0.1      100        1
had.rec.64	   4.3413574	     0.1      100        1
had.rec.65	   3.1325894	     0.1      100        1
had.rec.66	  0.10001466	     0.1      100        1
had.rec.67	   44.858473	     0.1      100        1
had.rec.68	   99.995885	     0.1      100        1
had.rec.69	   6.6694211	     0.1      100        1
had.rec.70	  0.10010415	     0.1      100        1
had.rec.71	  0.10009155	     0.1      100        1
had.rec.72	  0.36929193	     0.1      100        1
had.rec.73	   16.186882	     0.1      100        1
had.rec.74	   5.6282691	     0.1      100        1
had.rec.75	   16.245611	     0.1      100        1
had.rec.76	   3.0476233	     0.1      100        1
had.rec.77	    23.43672	     0.1      100        1
had.rec.78	  0.10029259	     0.1      100        1
had.rec.79	   59.435313	     0.1      100        1
had.rec.80	   99.995821	     0.1      100        1
had.rec.81	   99.999211	     0.1      100        1
had.rec.82	   93.835574	     0.1      100        1
had.rec.83	  0.10296276	     0.1      100        1
had.rec.84	   0.1000078	     0.1      100        1
had.rec.85	   7.9798129	     0.1      100        1
had.rec.86	     85.2228	     0.1      100        1
had.rec.87	   74.865443	     0.1      100        1
had.rec.88	   42.237928	     0.1      100        1
had.rec.89	   21.545716	     0.1      100        1
had.rec.90	   13.396175	     0.1      100        1
had.rec.91	   2.8069459	     0.1      100        1
had.rec.92	   26.508822	     0.1      100        1
had.rec.93	   8.8947065	     0.1      100        1
had.rec.94	   10.008404	     0.1      100        1
had.rec.95	  0.10034507	     0.1      100        1
had.rec.96	   62.558754	     0.1      100        1
had.rec.97	   99.999787	     0.1      100        1
had.rec.98	   99.998863	     0.1      100        1
had.rec.99	   45.592148	     0.1      100        1
had.rec.100	  0.98241026	     0.1      100        1
had.rec.101	   3.5135942	     0.1      100        1
had.rec.102	   25.542548	     0.1      100        1
had.rec.103	  0.10021994	     0.1      100        1
had.rec.104	   24.590754	     0.1      100        1
had.rec.105	   2.5506016	     0.1      100        1
had.rec.106	   14.128706	     0.1      100        1
had.rec.107	   26.185891	     0.1      100        1
had.rec.108	   30.051248	     0.1      100        1
had.rec.109	   2.3493393	     0.1      100        1
had.rec.110	   6.8852836	     0.1      100        1
had.rec.111	   25.388377	     0.1      100        1
had.rec.112	   4.3504616	     0.1      100        1
had.rec.113	   33.586291	     0.1      100        1
had.rec.114	   8.8390404	     0.1      100        1
had.rec.115	   20.571773	     0.1      100        1
had.rec.116	   8.5584983	     0.1      100        1
had.rec.117	   16.233916	     0.1      100        1
had.rec.118	   17.130465	     0.1      100        1
had.rec.119	   10.046653	     0.1      100        1
had.rec.120	  0.10054095	     0.1      100        1
had.surQ1.alpha	  0.11916809	     0.1        3        1
had.surQ1.l50	   67.730249	      21      126        1
had.surQ3.alpha	  0.15124262	     0.1        3        1
had.surQ3.l50	   68.778198	      12      123        1
had.com.alpha	  0.29452832	     0.1        3        1
had.com.l50	   65.653713	      42      105        1
