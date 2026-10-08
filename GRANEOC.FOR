       PROGRAM GRANEOC
C
C  Design equations for Classical Open-Cassegrain Dual-Reflector
C  Antennas from Combinations of Prescribed Geometric parameters
C  IEEE Antennas and Propagation Magazine, 
C
C  Equations by Christophe Granet
C
C  Code by T.A. Milligan
C
      DIMENSION CSR(3)
      TR=ACOS(0.)/90.
      OPEN(66,FILE='graneoc.out')
C
C  Example 1
C
C  Values for Option 1
C
C  Inputs:
C
C  FOCAL    Main reflector focal length
C  THO      Offset angle of main reflector
C  DS       Diameter of subreflector
C  THE      Angle between z-axis of the feed coordinate system and
C           the SR edge as seen from focus (half feed subtended angle)
C
      FOCAL=71.0855
	THO=53.931*TR
      DS=30
	THE=14.*TR
      CALL OCAGEO1(DM,FOCAL,THO,DS,ASR,FS,THMR,EC,THE,DISTM,THEM)
	DC=CLEARA(FOCAL,FS,THO,THMR,EC)
	HH=CENTERO(FOCAL,THO,THMR)
	WRITE(6,2)DM,FOCAL,THO/TR,DS,ASR,FS,THMR/TR,THE/TR,EC,DISTM,
     1 THEM/TR,DC,HH
	WRITE(66,2)DM,FOCAL,THO/TR,DS,ASR,FS,THMR/TR,THE/TR,EC,DISTM,
	1 THEM/TR,DC,HH
    2 FORMAT(/,' Open-Cassegrain Example: 1',//,' Option 1:',//,
     1' Main reflector diameter:          ',F9.4,/,
	2' Focal length:                     ',F9.4,/,
	3' Offset angle of main reflector:   ',F9.2,/,
	4' Subreflector diameter:            ',F9.4,/,
	5' Subreflector hyperboloid a:       ',F9.4,/,
	6' Half interfocal distance:         ',F9.4,/,
	7' Half subtended angle SR coord:    ',F9.2,/,
	8' Half feed subtended angle:        ',F9.2,/,
	8' Eccentricity:                     ',F9.4,/,
	9' MR surface to Feed point:         ',F9.4,/,
	1' SR edge angle from MR vertex:     ',F9.2,/,
	2' Beam clearance:                   ',F9.4,/,
	3' Center of MR offset:              ',F9.4)
C
C  Values for Option 2
C
C  Inputs:
C
C  DM       Main reflector diameter    
C  FOCAL    Main reflector focal length
C  DS       Diameter of subreflector
C  THE      Angle between z-axis of the feed coordinate system and
C           the SR edge as seen from focus (half feed subtended angle)
C
      DM=100.
	FOCAL=71.0844
	DS=30.
	THE=14.*TR
      CALL OCAGEO2(DM,FOCAL,THO,DS,ASR,FS,THMR,EC,THE,DISTM,THEM)
	DC=CLEARA(FOCAL,FS,THO,THMR,EC)
	HH=CENTERO(FOCAL,THO,THMR)
	WRITE(6,3)DM,FOCAL,THO/TR,DS,ASR,FS,THMR/TR,THE/TR,EC,DISTM,
     1 THEM/TR,DC,HH
	WRITE(66,3)DM,FOCAL,THO/TR,DS,ASR,FS,THMR/TR,THE/TR,EC,DISTM,
	1 THEM/TR,DC,HH
    3 FORMAT(/,' Open-Cassegrain Example: 1',//,' Option 2:',//,
     1' Main reflector diameter:          ',F9.4,/,
	2' Focal length:                     ',F9.4,/,
	3' Offset angle of main reflector:   ',F9.2,/,
	4' Subreflector diameter:            ',F9.4,/,
	5' Subreflector hyperboloid a:       ',F9.4,/,
	6' Half interfocal distance:         ',F9.4,/,
	7' Half subtended angle SR coord:    ',F9.2,/,
	8' Half feed subtended angle:        ',F9.2,/,
	8' Eccentricity:                     ',F9.4,/,
	9' MR surface to Feed point:         ',F9.4,/,
	1' SR edge angle from MR vertex:     ',F9.2,/,
	2' Beam clearance:                   ',F9.4,/,
	3' Center of MR offset:              ',F9.4)
C
C  Values for Option 3
C
C  Inputs:
C
C  DM       Main reflector diameter    
C  FOCAL    Main reflector focal length
C  THE      Angle between z-axis of the feed coordinate system and
C           the SR edge as seen from focus (half feed subtended angle)
C  THO      Offset angle of main reflector
C
      DM=100
	FOCAL=71.0844
	THE=14.*TR
	THO=53.931*TR
      CALL OCAGEO3(DM,FOCAL,THO,DS,ASR,FS,THMR,EC,THE,DISTM,THEM)
	DC=CLEARA(FOCAL,FS,THO,THMR,EC)
	HH=CENTERO(FOCAL,THO,THMR)
	WRITE(6,4)DM,FOCAL,THO/TR,DS,ASR,FS,THMR/TR,THE/TR,EC,DISTM,
     1 THEM/TR,DC,HH
	WRITE(66,4)DM,FOCAL,THO/TR,DS,ASR,FS,THMR/TR,THE/TR,EC,DISTM,
	1 THEM/TR,DC,HH
    4 FORMAT(/,' Open-Cassegrain Example: 1',//,' Option 3:',//,
     1' Main reflector diameter:          ',F9.4,/,
	2' Focal length:                     ',F9.4,/,
	3' Offset angle of main reflector:   ',F9.2,/,
	4' Subreflector diameter:            ',F9.4,/,
	5' Subreflector hyperboloid a:       ',F9.4,/,
	6' Half interfocal distance:         ',F9.4,/,
	7' Half subtended angle SR coord:    ',F9.2,/,
	8' Half feed subtended angle:        ',F9.2,/,
	8' Eccentricity:                     ',F9.4,/,
	9' MR surface to Feed point:         ',F9.4,/,
	1' SR edge angle from MR vertex:     ',F9.2,/,
	2' Beam clearance:                   ',F9.4,/,
	3' Center of MR offset:              ',F9.4)
C
C  Values for Option 4
C
C  Inputs:
C
C  DM       Main reflector diameter    
C  THO      Offset angle of main reflector
C  DS       Diameter of subreflector
C  DISTM    Distance between MR-surface and the focus of the antenna along
C           offset angle (THO) of the MR
C
      DM=100.
	THO=53.931*TR
	DS=30.
	DISTM=4.
      CALL OCAGEO4(DM,FOCAL,THO,DS,ASR,FS,THMR,EC,THE,DISTM,THEM)
	DC=CLEARA(FOCAL,FS,THO,THMR,EC)
	HH=CENTERO(FOCAL,THO,THMR)
	WRITE(6,5)DM,FOCAL,THO/TR,DS,ASR,FS,THMR/TR,THE/TR,EC,DISTM,
     1 THEM/TR,DC,HH
	WRITE(66,5)DM,FOCAL,THO/TR,DS,ASR,FS,THMR/TR,THE/TR,EC,DISTM,
	1 THEM/TR,DC,HH
    5 FORMAT(/,' Open-Cassegrain Example: 1',//,' Option 4:',//,
     1' Main reflector diameter:          ',F9.4,/,
	2' Focal length:                     ',F9.4,/,
	3' Offset angle of main reflector:   ',F9.2,/,
	4' Subreflector diameter:            ',F9.4,/,
	5' Subreflector hyperboloid a:       ',F9.4,/,
	6' Half interfocal distance:         ',F9.4,/,
	7' Half subtended angle SR coord:    ',F9.2,/,
	8' Half feed subtended angle:        ',F9.2,/,
	8' Eccentricity:                     ',F9.4,/,
	9' MR surface to Feed point:         ',F9.4,/,
	1' SR edge angle from MR vertex:     ',F9.2,/,
	2' Beam clearance:                   ',F9.4,/,
	3' Center of MR offset:              ',F9.4)
C
C  Values for Option 5
C
C  Inputs:
C
C  DM       Main reflector diameter    
C  DS       Diameter of subreflector
C  THE      Angle between z-axis of the feed coordinate system and
C           the SR edge as seen from focus (half feed subtended angle)
C  DISTM    Distance between MR-surface and the focus of the antenna along
C           offset angle (THO) of the MR
C
      DM=100.
	DS=30.
	DISTM=4.
	THE=14.*TR
      CALL OCAGEO5(DM,FOCAL,THO,DS,ASR,FS,THMR,EC,THE,DISTM,THEM)
	DC=CLEARA(FOCAL,FS,THO,THMR,EC)
	HH=CENTERO(FOCAL,THO,THMR)
	WRITE(6,1)DM,FOCAL,THO/TR,DS,ASR,FS,THMR/TR,THE/TR,EC,DISTM,
     1 THEM/TR,DC,HH
	WRITE(66,1)DM,FOCAL,THO/TR,DS,ASR,FS,THMR/TR,THE/TR,EC,DISTM,
	1 THEM/TR,DC,HH
    1 FORMAT(/,' Open-Cassegrain Example: 1',//,' Option 5:',//,
     1' Main reflector diameter:          ',F9.4,/,
	2' Focal length:                     ',F9.4,/,
	3' Offset angle of main reflector:   ',F9.2,/,
	4' Subreflector diameter:            ',F9.4,/,
	5' Subreflector hyperboloid a:       ',F9.4,/,
	6' Half interfocal distance:         ',F9.4,/,
	7' Half subtended angle SR coord:    ',F9.2,/,
	8' Half feed subtended angle:        ',F9.2,/,
	8' Eccentricity:                     ',F9.4,/,
	9' MR surface to Feed point:         ',F9.4,/,
	1' SR edge angle from MR vertex:     ',F9.2,/,
	2' Beam clearance:                   ',F9.4,/,
	3' Center of MR offset:              ',F9.4)
C
C  Example 2
C
C  Values for Option 1
C
C  Inputs:
C
C  FOCAL    Main reflector focal length
C  THO      Offset angle of main reflector
C  DS       Diameter of subreflector
C  THE      Angle between z-axis of the feed coordinate system and
C           the SR edge as seen from focus (half feed subtended angle)
C
      FOCAL=32.5142
	THO=56.6898*TR
      DS=15
	THE=16.*TR
      CALL OCAGEO1(DM,FOCAL,THO,DS,ASR,FS,THMR,EC,THE,DISTM,THEM)
	DC=CLEARA(FOCAL,FS,THO,THMR,EC)
	HH=CENTERO(FOCAL,THO,THMR)
	WRITE(6,6)DM,FOCAL,THO/TR,DS,ASR,FS,THMR/TR,THE/TR,EC,DISTM,
     1 THEM/TR,DC,HH
	WRITE(66,6)DM,FOCAL,THO/TR,DS,ASR,FS,THMR/TR,THE/TR,EC,DISTM,
	1 THEM/TR,DC,HH
    6 FORMAT(/,' Open-Cassegrain Example: 2',//,' Option 1:',//,
     1' Main reflector diameter:          ',F9.4,/,
	2' Focal length:                     ',F9.4,/,
	3' Offset angle of main reflector:   ',F9.2,/,
	4' Subreflector diameter:            ',F9.4,/,
	5' Subreflector hyperboloid a:       ',F9.4,/,
	6' Half interfocal distance:         ',F9.4,/,
	7' Half subtended angle SR coord:    ',F9.2,/,
	8' Half feed subtended angle:        ',F9.2,/,
	8' Eccentricity:                     ',F9.4,/,
	9' MR surface to Feed point:         ',F9.4,/,
	1' SR edge angle from MR vertex:     ',F9.2,/,
	2' Beam clearance:                   ',F9.4,/,
	3' Center of MR offset:              ',F9.4)
C
C  Values for Option 2
C
C  Inputs:
C
C  DM       Main reflector diameter    
C  FOCAL    Main reflector focal length
C  DS       Diameter of subreflector
C  THE      Angle between z-axis of the feed coordinate system and
C           the SR edge as seen from focus (half feed subtended angle)
C
      DM=50.
	FOCAL=32.5142
	DS=15.
	THE=16.*TR
      CALL OCAGEO2(DM,FOCAL,THO,DS,ASR,FS,THMR,EC,THE,DISTM,THEM)
	DC=CLEARA(FOCAL,FS,THO,THMR,EC)
	HH=CENTERO(FOCAL,THO,THMR)
	WRITE(6,7)DM,FOCAL,THO/TR,DS,ASR,FS,THMR/TR,THE/TR,EC,DISTM,
     1 THEM/TR,DC,HH
	WRITE(66,7)DM,FOCAL,THO/TR,DS,ASR,FS,THMR/TR,THE/TR,EC,DISTM,
	1 THEM/TR,DC,HH
    7 FORMAT(/,' Open-Cassegrain Example: 2',//,' Option 2:',//,
     1' Main reflector diameter:          ',F9.4,/,
	2' Focal length:                     ',F9.4,/,
	3' Offset angle of main reflector:   ',F9.2,/,
	4' Subreflector diameter:            ',F9.4,/,
	5' Subreflector hyperboloid a:       ',F9.4,/,
	6' Half interfocal distance:         ',F9.4,/,
	7' Half subtended angle SR coord:    ',F9.2,/,
	8' Half feed subtended angle:        ',F9.2,/,
	8' Eccentricity:                     ',F9.4,/,
	9' MR surface to Feed point:         ',F9.4,/,
	1' SR edge angle from MR vertex:     ',F9.2,/,
	2' Beam clearance:                   ',F9.4,/,
	3' Center of MR offset:              ',F9.4)
C
C  Values for Option 3
C
C  Inputs:
C
C  DM       Main reflector diameter    
C  FOCAL    Main reflector focal length
C  THE      Angle between z-axis of the feed coordinate system and
C           the SR edge as seen from focus (half feed subtended angle)
C  THO      Offset angle of main reflector
C
      DM=50
	FOCAL=32.5142
	THE=16.*TR
	THO=56.6898*TR
      CALL OCAGEO3(DM,FOCAL,THO,DS,ASR,FS,THMR,EC,THE,DISTM,THEM)
	DC=CLEARA(FOCAL,FS,THO,THMR,EC)
	HH=CENTERO(FOCAL,THO,THMR)
	WRITE(6,8)DM,FOCAL,THO/TR,DS,ASR,FS,THMR/TR,THE/TR,EC,DISTM,
     1 THEM/TR,DC,HH
	WRITE(66,8)DM,FOCAL,THO/TR,DS,ASR,FS,THMR/TR,THE/TR,EC,DISTM,
	1 THEM/TR,DC,HH
    8 FORMAT(/,' Open-Cassegrain Example: 2',//,' Option 3:',//,
     1' Main reflector diameter:          ',F9.4,/,
	2' Focal length:                     ',F9.4,/,
	3' Offset angle of main reflector:   ',F9.2,/,
	4' Subreflector diameter:            ',F9.4,/,
	5' Subreflector hyperboloid a:       ',F9.4,/,
	6' Half interfocal distance:         ',F9.4,/,
	7' Half subtended angle SR coord:    ',F9.2,/,
	8' Half feed subtended angle:        ',F9.2,/,
	8' Eccentricity:                     ',F9.4,/,
	9' MR surface to Feed point:         ',F9.4,/,
	1' SR edge angle from MR vertex:     ',F9.2,/,
	2' Beam clearance:                   ',F9.4,/,
	3' Center of MR offset:              ',F9.4)
C
C  Values for Option 4
C
C  Inputs:
C
C  DM       Main reflector diameter    
C  THO      Offset angle of main reflector
C  DS       Diameter of subreflector
C  DISTM    Distance between MR-surface and the focus of the antenna along
C           offset angle (THO) of the MR
C
      DM=50.
	THO=56.6898*TR
	DS=15.
	DISTM=4.
      CALL OCAGEO4(DM,FOCAL,THO,DS,ASR,FS,THMR,EC,THE,DISTM,THEM)
	DC=CLEARA(FOCAL,FS,THO,THMR,EC)
	HH=CENTERO(FOCAL,THO,THMR)
	WRITE(6,9)DM,FOCAL,THO/TR,DS,ASR,FS,THMR/TR,THE/TR,EC,DISTM,
     1 THEM/TR,DC,HH
	WRITE(66,9)DM,FOCAL,THO/TR,DS,ASR,FS,THMR/TR,THE/TR,EC,DISTM,
	1 THEM/TR,DC,HH
    9 FORMAT(/,' Open-Cassegrain Example: 2',//,' Option 4:',//,
     1' Main reflector diameter:          ',F9.4,/,
	2' Focal length:                     ',F9.4,/,
	3' Offset angle of main reflector:   ',F9.2,/,
	4' Subreflector diameter:            ',F9.4,/,
	5' Subreflector hyperboloid a:       ',F9.4,/,
	6' Half interfocal distance:         ',F9.4,/,
	7' Half subtended angle SR coord:    ',F9.2,/,
	8' Half feed subtended angle:        ',F9.2,/,
	8' Eccentricity:                     ',F9.4,/,
	9' MR surface to Feed point:         ',F9.4,/,
	1' SR edge angle from MR vertex:     ',F9.2,/,
	2' Beam clearance:                   ',F9.4,/,
	3' Center of MR offset:              ',F9.4)
C
C  Values for Option 5
C
C  Inputs:
C
C  DM       Main reflector diameter    
C  DS       Diameter of subreflector
C  THE      Angle between z-axis of the feed coordinate system and
C           the SR edge as seen from focus (half feed subtended angle)
C  DISTM    Distance between MR-surface and the focus of the antenna along
C           offset angle (THO) of the MR
C
      DM=50.
	DS=15.
	DISTM=4.
	THE=16.*TR
      CALL OCAGEO5(DM,FOCAL,THO,DS,ASR,FS,THMR,EC,THE,DISTM,THEM)
	DC=CLEARA(FOCAL,FS,THO,THMR,EC)
	HH=CENTERO(FOCAL,THO,THMR)
	WRITE(6,10)DM,FOCAL,THO/TR,DS,ASR,FS,THMR/TR,THE/TR,EC,DISTM,
     1 THEM/TR,DC,HH
	WRITE(66,10)DM,FOCAL,THO/TR,DS,ASR,FS,THMR/TR,THE/TR,EC,DISTM,
	1 THEM/TR,DC,HH
   10 FORMAT(/,' Open-Cassegrain Example: 2',//,' Option 5:',//,
     1' Main reflector diameter:          ',F9.4,/,
	2' Focal length:                     ',F9.4,/,
	3' Offset angle of main reflector:   ',F9.2,/,
	4' Subreflector diameter:            ',F9.4,/,
	5' Subreflector hyperboloid a:       ',F9.4,/,
	6' Half interfocal distance:         ',F9.4,/,
	7' Half subtended angle SR coord:    ',F9.2,/,
	8' Half feed subtended angle:        ',F9.2,/,
	8' Eccentricity:                     ',F9.4,/,
	9' MR surface to Feed point:         ',F9.4,/,
	1' SR edge angle from MR vertex:     ',F9.2,/,
	2' Beam clearance:                   ',F9.4,/,
	3' Center of MR offset:              ',F9.4)
	END
      SUBROUTINE OCAGEO1(DM,FOCAL,THO,DS,ASR,FS,THMR,EC,THE,DISTM,
     1 THEM)
C
C  Design equations for Classical Open-Cassegrain Dual-Reflector
C  Antennas from Combinations of Prescribed Geometric parameters
C  IEEE Antennas and Propagation Magazine, 
C
C  Equations by Christophe Granet
C
C  Code by T.A. Milligan
C
C  Parameters:
C
C  Inputs:
C
C  FOCAL    Main reflector focal length
C  THO      Offset angle of main reflector
C  DS       Diameter of subreflector
C  THE      Angle between z-axis of the feed coordinate system and
C           the SR edge as seen from focus (half feed subtended angle)
C
C  Outputs:
C
C  DM       Main reflector diameter    
C  ASR      a: parameter of the SR hyperboloid
C  FS       Half the interfocal distance of the hyperboloid
C  THMR     Half subtended angle of SR as seen from the SR coordinates
C  EC       Eccentricity of the hyperboloid
C  DISTM    Distance between MR-surface and the focus of the antenna along
C           offset angle (THO) of the MR
C  THEM     Angle between the z-axis of the feed coordinate system and the 
C           SR-edge as seen from the point Q
C
      DIMENSION X(10),XR(4)
	EXTERNAL THMRR
	TR=ACOS(0.)/90.
C
C  Compute THMR
C
      X(2)=FOCAL
	X(3)=THO
	X(4)=DS
	X1=TR*10.
	X2=TR*80.
	XACC=1.E-5
	nn=141
	VF=0.
      DO 3 I=1,141
	X(1)=(80.-FLOAT(I-1)*.5)*TR
	THF=THMRR(X)
	IF(THF*VF.LT.0.)THEN
      X1=X(1)-TR
	X2=X(1)+TR
	GOTO 5
	ENDIF
	VF=THF
    3 CONTINUE
    5 CONTINUE	
	THMR=RTFLSP(THMRR,X,1,X1,X2,XACC)
C  Equation 1
      DM=4.*FOCAL*SIN(THMR)/(COS(THMR)+COS(THO))
C  Equation 5
      BETA=(SIN(THMR)*COS(THE)-SIN(THE)*COS(THMR))/(SIN(THE)+SIN(THMR))
	EC=1./BETA
C  Equation 10
      FS=DS*(COS(THE)-BETA)/(2.*(1.-BETA**2)*SIN(THE))
C  Equation 6
      DISTM=2.*FOCAL/(1.+COS(THO))-2.*FS
C  Equation 7
      THEM=ATAN(DS*(1.+COS(THO))*TAN(THMR)/(4.*FOCAL*TAN(THMR)-DS*(
     1 1.+COS(THO))))
	ASR=DS*(EC*COS(THE)-1.)/(2.*(EC**2-1.)*COS(THE))
      RETURN
	END					
	FUNCTION THMRR(X)
C
C  Root function for THMR: Half subtended angle of SR as seen from the 
C  SR coordinates
C   
C  X(1)    THMR
C  X(2)    Main reflector focal length
C  X(3)    Offset angle of main reflector
C  X(4)    Diameter of subreflector
C
      DIMENSION X(1)
	TR=ACOS(0.)/90.
	THMRR=X(4)-4.*X(2)*SIN(X(3)-X(1))*SIN(X(1))/((1.+COS(X(3)-X(1)))*
     1 SIN(X(3)+X(1)))
	RETURN
	END
      SUBROUTINE OCAGEO2(DM,FOCAL,THO,DS,ASR,FS,THMR,EC,THE,DISTM,
     1 THEM)
C
C  Design equations for Classical Open-Cassegrain Dual-Reflector
C  Antennas from Combinations of Prescribed Geometric parameters
C  IEEE Antennas and Propagation Magazine, 
C
C  Equations by Christophe Granet
C
C  Code by T.A. Milligan
C
C  Parameters:
C
C  Inputs:
C
C  DM       Main reflector diameter    
C  FOCAL    Main reflector focal length
C  DS       Diameter of subreflector
C  THE      Angle between z-axis of the feed coordinate system and
C           the SR edge as seen from focus (half feed subtended angle)
C
C  Outputs:
C
C  THO      Offset angle of main reflector
C  ASR      a: parameter of the SR hyperboloid
C  FS       Half the interfocal distance of the hyperboloid
C  THMR     Half subtended angle of SR as seen from the SR coordinates
C  EC       Eccentricity of the hyperboloid
C  DISTM    Distance between MR-surface and the focus of the antenna along
C           offset angle (THO) of the MR
C  THEM     Angle between the z-axis of the feed coordinate system and the 
C           SR-edge as seen from the point Q
C
      DIMENSION X(10)
	EXTERNAL THMRM,THMRRP
	TR=ACOS(0.)/90.
C
C  Compute THMRM
C
      X(2)=FOCAL
	X(3)=DM
	X(4)=DS
	X1=TR*10.
	X2=TR*50.
	XACC=1.E-5
	THMRX=RTFLSP(THMRM,X,1,X1,X2,XACC)
	X2=THMRX-TR/2.
C
C  Compute THMR
C
      X(2)=FOCAL
	X(3)=DM
	X(4)=DS
	X1=TR*10.
	XACC=1.E-5
	NN=101
	THMR=RTFLSP(THMRRP,X,1,X1,X2,XACC)
	THO=ACOS((4.*X(2)*SIN(THMR)-X(3)*COS(THMR))/X(3))
C  Equation 5
      BETA=(SIN(THMR)*COS(THE)-SIN(THE)*COS(THMR))/(SIN(THE)+SIN(THMR))
	EC=1./BETA
C  Equation 10
      FS=DS*(COS(THE)-BETA)/(2.*(1.-BETA**2)*SIN(THE))
C  Equation 6
      DISTM=2.*FOCAL/(1.+COS(THO))-2.*FS
C  Equation 7
      THEM=ATAN(DS*(1.+COS(THO))*TAN(THMR)/(4.*FOCAL*TAN(THMR)-DS*(
     1 1.+COS(THO))))
	ASR=DS*(EC*COS(THE)-1.)/(2.*(EC**2-1.)*COS(THE))
      RETURN
	END					
	FUNCTION THMRM(X)
C
C  Root function for THMR_MAX: Max Half subtended angle of SR as seen from the 
C  SR coordinates
C   
C  X(1)    THMRM
C  X(2)    Main reflector focal length
C  X(3)    Diameter of main reflector
C  X(4)    Diameter of subreflector
C
      DIMENSION X(1)
	THMRM=(4.*X(2)*SIN(X(1))-X(3)*COS(X(1)))/X(3)-1.
	RETURN
	END
	FUNCTION THMRRP(X)
C
C  Root function for THMR: Half subtended angle of SR as seen from the 
C  SR coordinates opt: 2
C   
C  X(1)    THMR
C  X(2)    Main reflector focal length
C  X(3)    Diameter of main reflector
C  X(4)    Diameter of subreflector
C
      DIMENSION X(1)
	THO=ACOS((4.*X(2)*SIN(X(1))-X(3)*COS(X(1)))/X(3))
	THMRRP=X(4)-4.*X(2)*SIN(THO-X(1))*SIN(X(1))/((1.+COS(THO-X(1)))*
     1 SIN(THO+X(1)))
	RETURN
	END
      SUBROUTINE OCAGEO3(DM,FOCAL,THO,DS,ASR,FS,THMR,EC,THE,DISTM,
     1 THEM)
C
C  Design equations for Classical Open-Cassegrain Dual-Reflector
C  Antennas from Combinations of Prescribed Geometric parameters
C  IEEE Antennas and Propagation Magazine, 
C
C  Equations by Christophe Granet
C
C  Code by T.A. Milligan
C
C  Parameters:
C
C  Inputs:
C
C  DM       Main reflector diameter    
C  FOCAL    Main reflector focal length
C  THE      Angle between z-axis of the feed coordinate system and
C           the SR edge as seen from focus (half feed subtended angle)
C  THO      Offset angle of main reflector
C
C  Outputs:
C
C  DS       Diameter of subreflector
C  ASR      a: parameter of the SR hyperboloid
C  FS       Half the interfocal distance of the hyperboloid
C  THMR     Half subtended angle of SR as seen from the SR coordinates
C  EC       Eccentricity of the hyperboloid
C  DISTM    Distance between MR-surface and the focus of the antenna along
C           offset angle (THO) of the MR
C  THEM     Angle between the z-axis of the feed coordinate system and the 
C           SR-edge as seen from the point Q
C
      DIMENSION X(10)
	EXTERNAL THMRD
	TR=ACOS(0.)/90.
C
C  Compute THMR
C
      X(2)=FOCAL
	X(3)=THO
	X(4)=DM
	X1=TR*10.
	X2=TR*80.
	XACC=1.E-5
	THMR=RTFLSP(THMRD,X,1,X1,X2,XACC)
C  Equation 2
      DS=4.*FOCAL*SIN(THO-THMR)*SIN(THMR)/((1.+COS(THO-THMR))*
     1 SIN(THO+THMR))
C  Equation 5
      BETA=(SIN(THMR)*COS(THE)-SIN(THE)*COS(THMR))/(SIN(THE)+SIN(THMR))
	EC=1./BETA
C  Equation 10
      FS=DS*(COS(THE)-BETA)/(2.*(1.-BETA**2)*SIN(THE))
C  Equation 6
      DISTM=2.*FOCAL/(1.+COS(THO))-2.*FS
C  Equation 7
      THEM=ATAN(DS*(1.+COS(THO))*TAN(THMR)/(4.*FOCAL*TAN(THMR)-DS*(
     1 1.+COS(THO))))
	ASR=DS*(EC*COS(THE)-1.)/(2.*(EC**2-1.)*COS(THE))
      RETURN
	END					
	FUNCTION THMRD(X)
C
C  Root function for THMR: Half subtended angle of SR as seen from the 
C  SR coordinates
C   
C  X(1)    THMR
C  X(2)    Main reflector focal length
C  X(3)    Offset angle of main reflector
C  X(4)    Diameter of Main reflector
C
      DIMENSION X(1)
	THMRD=X(4)-4.*X(2)*SIN(X(1))/(COS(X(1))+COS(X(3)))
	RETURN
	END
      SUBROUTINE OCAGEO4(DM,FOCAL,THO,DS,ASR,FS,THMR,EC,THE,DISTM,
     1 THEM)
C
C  Design equations for Classical Open-Cassegrain Dual-Reflector
C  Antennas from Combinations of Prescribed Geometric parameters
C  IEEE Antennas and Propagation Magazine, 
C
C  Equations by Christophe Granet
C
C  Code by T.A. Milligan
C
C  Parameters:
C
C  Inputs:
C
C  DM       Main reflector diameter    
C  THO      Offset angle of main reflector
C  DS       Diameter of subreflector
C  DISTM    Distance between MR-surface and the focus of the antenna along
C           offset angle (THO) of the MR
C
C  Outputs:
C
C  FOCAL    Main reflector focal length
C  THE      Angle between z-axis of the feed coordinate system and
C           the SR edge as seen from focus (half feed subtended angle)
C  ASR      a: parameter of the SR hyperboloid
C  FS       Half the interfocal distance of the hyperboloid
C  THMR     Half subtended angle of SR as seen from the SR coordinates
C  EC       Eccentricity of the hyperboloid
C  THEM     Angle between the z-axis of the feed coordinate system and the 
C           SR-edge as seen from the point Q
C
      DIMENSION X(10),A(3)
	COMPLEX ROOTS(2)
	EXTERNAL THMRF
	TR=ACOS(0.)/90.
C
C  Compute THMR
C
      X(2)=DS
	X(3)=THO
	X(4)=DM
	X1=TR*10.
	X2=TR*80.
	XACC=1.E-5
	THMR=RTFLSP(THMRF,X,1,X1,X2,XACC)
	FOCAL=DM*(COS(THMR)+COS(THO))/(4.*SIN(THMR))
	FS=FOCAL/(1.+COS(THO))-DISTM/2.
	A(1)=DS*COS(THMR)-2.*FS*SIN(THMR)
	A(2)=DS
	A(3)=2.*FS*SIN(THMR)
	CALL QUADR(A,ROOTS,ICOMP)
	BETA=REAL(ROOTS(1))
	IF(BETA.GE.1..OR.BETA.LE.0.)BETA=REAL(ROOTS(2))
	EC=1./BETA
C  Equation 3
      THE=ACOS(((1.+BETA**2)*COS(THMR)+2.*BETA)/(1.+BETA**2+2.*BETA
     1 *COS(THMR)))
C  Equation 7
      THEM=ATAN(DS*(1.+COS(THO))*TAN(THMR)/(4.*FOCAL*TAN(THMR)-DS*(
     1 1.+COS(THO))))
	ASR=DS*(EC*COS(THE)-1.)/(2.*(EC**2-1.)*COS(THE))
      RETURN
	END					
	FUNCTION THMRF(X)
C
C  Root function for THMR: Half subtended angle of SR as seen from the 
C  SR coordinates
C   
C  X(1)    THMR
C  X(2)    Diameter of subreflector
C  X(3)    Offset angle of main reflector
C  X(4)    Diameter of main reflector
C
      DIMENSION X(1)
	FOC=X(4)*(COS(X(1))+COS(X(3)))/(4.*SIN(X(1)))
	THMRF=X(2)-4.*FOC*SIN(X(3)-X(1))*SIN(X(1))/((1.+COS(X(3)-X(1)))*
     1 SIN(X(3)+X(1)))
	RETURN
	END
      SUBROUTINE QUADR(A,ROOTS,ICOMP) 
C 
C  Roots of quadratic equation
C 
C  A(3)   Coefficients of polynomial
C         A(1)+X*A(2)+X**2*A(3) 
C  ROOTS(2)  Roots of equation
C  ICOMP  = 1 if complex roots, 0 otherwise 
C 
      DIMENSION A(3)
      COMPLEX ROOTS(2),Q,RADCC
      RADC=A(2)*A(2)-4.*A(1)*A(3) 
      RADCC=CMPLX(RADC,0.)  
      ICOMP=0 
      IF(RADC.LT.0.)ICOMP=1 
      Q=-(A(2)+SIGN(1.,A(2))*CSQRT(RADCC))/2. 
      ROOTS(1)=Q/A(3) 
      ROOTS(2)=A(1)/Q 
      RETURN
      END
      SUBROUTINE OCAGEO5(DM,FOCAL,THO,DS,ASR,FS,THMR,EC,THE,DISTM,
     1 THEM)
C
C  Design equations for Classical Open-Cassegrain Dual-Reflector
C  Antennas from Combinations of Prescribed Geometric parameters
C  IEEE Antennas and Propagation Magazine, 
C
C  Equations by Christophe Granet
C
C  Code by T.A. Milligan
C
C  Parameters:
C
C  Inputs:
C
C  DM       Main reflector diameter    
C  DS       Diameter of subreflector
C  THE      Angle between z-axis of the feed coordinate system and
C           the SR edge as seen from focus (half feed subtended angle)
C  DISTM    Distance between MR-surface and the focus of the antenna along
C           offset angle (THO) of the MR
C
C  Outputs:
C
C  FOCAL    Main reflector focal length
C  THO      Offset angle of main reflector
C  ASR      a: parameter of the SR hyperboloid
C  FS       Half the interfocal distance of the hyperboloid
C  THMR     Half subtended angle of SR as seen from the SR coordinates
C  EC       Eccentricity of the hyperboloid
C  THEM     Angle between the z-axis of the feed coordinate system and the 
C           SR-edge as seen from the point Q
C
      DIMENSION X(10)
	EXTERNAL THEMR,THMRX,THMRE
	TR=ACOS(0.)/90.
C
C  Compute THEM
C
      X(2)=DS
	X(3)=THE
	X(4)=DISTM
	X1=TR*5.
	X2=TR*45.
	XACC=1.E-5
	THEM=RTFLSP(THEMR,X,1,X1,X2,XACC)
	X(2)=DM
	X(3)=THEM
	X(4)=DS
	VP=0.
	DO 1 I=1,81
	X(1)=X1+FLOAT(I-1)*(X2-X1)/80.
	THXX=THMRX(X)
	IF(THXX*VP.LT.0.)THEN
	X1=X(1)-TR
	X2=X(1)+TR
	GOTO 3
	ENDIF
	VP=THXX
    1 CONTINUE
    3	THR2=RTFLSP(THMRX,X,1,X1,X2,XACC)
	X2=THR2
	X1=X2-2.*TR
	THMR=RTFLSP(THMRE,X,1,X1,X2,XACC)
	A=DM*TAN(THMR)*TAN(THEM)
	B=DM*COS(THMR)*TAN(THMR)*TAN(THEM)
	C=DS*SIN(THMR)*(TAN(THMR)+TAN(THEM))
      THO=ACOS((C-B)/(A-C))
	FOCAL=DS*(1.+COS(THO))*(TAN(THMR)+TAN(X(3)))/(4.*TAN(THMR)
     1 *TAN(X(3)))
C  Equation 5
      BETA=(SIN(THMR)*COS(THE)-SIN(THE)*COS(THMR))/(SIN(THE)+SIN(THMR))
	EC=1./BETA
C  Equation 10
      FS=DS*(COS(THE)-BETA)/(2.*(1.-BETA**2)*SIN(THE))
	ASR=DS*(EC*COS(THE)-1.)/(2.*(EC**2-1.)*COS(THE))
      RETURN
	END					
	FUNCTION THEMR(X)
C
C  Root function for THEM: Angle between the z-axis of the feed coordinate system and the 
C           SR-edge as seen from the point Q
C   
C  X(1)    THEM
C  X(2)    Diameter of subreflector
C  X(3)    Angle between z-axis of the feed coordinate system and
C           the SR edge as seen from focus (half feed subtended angle)
C  X(4)    Distance between MR-surface and the focus of the antenna along
C           offset angle (THO) of the MR
C
      DIMENSION X(1)
	THEMR=SIN(X(3)-X(1))/X(4)-2.*SIN(X(1))*SIN(X(3))/X(2)
	RETURN
	END
	FUNCTION THMRX(X)
C
C  Root function for THMR_MAX: Half subtended angle of SR as seen from the 
C  SR coordinates
C   
C  X(1)    THMR_MAX
C  X(2)    Main reflector diameter
C  X(3)    Angle between the z-axis of the feed coordinate system and the 
C           SR-edge as seen from the point Q
C  X(4)    Diameter of subreflector
C
      DIMENSION X(1)
	A=X(2)*TAN(X(1))*TAN(X(3))
	B=A*COS(X(1))
	C=X(4)*SIN(X(1))*(TAN(X(1))+TAN(X(3)))
	THMRX=(C-B)/(A-C)-1.
	RETURN
	END
	FUNCTION THMRE(X)
C
C  Root function for THMR: Half subtended angle of SR as seen from the 
C  SR coordinates
C   
C  X(1)    THMR
C  X(2)    Diameter of main reflector
C  X(3)    Angle between the z-axis of the feed coordinate system and the 
C           SR-edge as seen from the point Q
C  X(4)    Diameter of subreflector
C
      DIMENSION X(1)
	A=X(2)*TAN(X(1))*TAN(X(3))
	B=A*COS(X(1))
	C=X(4)*SIN(X(1))*(TAN(X(1))+TAN(X(3)))
      THO=ACOS((C-B)/(A-C))
	FOC=X(4)*(1.+COS(THO))*(TAN(X(1))+TAN(X(3)))/(4.*TAN(X(1))
     1 *TAN(X(3)))
	THMRE=X(4)-4.*FOC*SIN(THO-X(1))*SIN(X(1))/((1.+COS(THO-X(1)))*
     1 SIN(THO+X(1)))
	RETURN
	END
	FUNCTION CLEARA(FOCAL,FS,THO,THMR,EC)
C
C  Clearance check for main beam with subreflector of open-Cassegrain
C
C  FOCAL    Main reflector focal length
C  FS       Half the interfocal distance of the hyperboloid
C  THO      Offset angle of main reflector
C  THMR     Half subtended angle of SR as seen from the SR coordinates
C  EC       Eccentricity of the hyperboloid
C
      BETA=1./EC
      CLEARA=2.*FOCAL*SIN(THO-THMR)/(1.+COS(THO-THMR))
	1 -FS*(1.-BETA**2)*SIN(THO+THMR)/(COS(THMR)+BETA)
	RETURN
	END
	FUNCTION CENTERO(FOCAL,THO,THMR)
C
C  Main reflector center offset
C
C  FOCAL    Main reflector focal length
C  THO      Offset angle of main reflector
C  THMR     Half subtended angle of SR as seen from the SR coordinates
C
      CENTERO=FOCAL*(SIN(THO-THMR)/(1.+COS(THO-THMR))
	1+SIN(THO+THMR)/(1.+COS(THO+THMR)))
	RETURN
	END
      FUNCTION rtflsp(func,X,NX,x1,x2,xacc)
C
C  Finds root of func using regula falsi to an accuracy  xacc
C  X   Array of variable passed to func
C  NX  Variable number of func for root
C  x1 and x2 bracket the root
C
      INTEGER MAXIT
      DIMENSION X(1)
      REAL rtflsp,x1,x2,xacc,func
      EXTERNAL func
C ---- MAXIT  Maximum number of iterations
      PARAMETER (MAXIT=30)
      INTEGER j
      REAL del,dx,f,fh,fl,swap,xh,xl
      X(NX)=X1
      fl=func(x)
      X(NX)=X2
      fh=func(x)
      if(fl*fh.gt.0.) pause 'root must be bracketed in rtflsp'
      if(fl.lt.0.)then
C ---- Identify the limits so that x1 corresponds to the low side
        xl=x1
        xh=x2
      else
        xl=x2
        xh=x1
        swap=fl
        fl=fh
        fh=swap
      endif
      dx=xh-xl
C ---- False position loop
      do 11 j=1,MAXIT
C ---- Increment with respect to latest value
        rtflsp=xl+dx*fl/(fl-fh)
        X(NX)=RTFLSP
        f=func(X)
        if(f.lt.0.) then
C ---- Replace appropriate limit
          del=xl-rtflsp
          xl=rtflsp
          fl=f
        else
          del=xh-rtflsp
          xh=rtflsp
          fh=f
        endif
        dx=xh-xl
C ---- Convergence
        if(abs(del).lt.xacc.or.f.eq.0.)return
11    continue
      pause 'rtflsp exceed maximum iterations'
      END
C  (C) Copr. 1986-92 Numerical Recipes Software pp. 347 - 350

