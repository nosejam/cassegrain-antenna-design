      SUBROUTINE ADEGEP(DIA,FOCAL,SDIA,FPSI,CA,TILT,CS,AA,BB)
C 
C  Displaced axis dual reflector subreflector geometry Granet's
C  formulas
C 
C  Inputs:
C 
C  DIA  Main reflector diameter
C  FOCAL Focal length of main reflector
C  SDIA  Subreflector diameter
C  FPSI  Feed half subtended angle (radians)
C 
C 
C  Outputs:
C 
C  CA  Distance from main vertex to feed
C  TILT  Subreflector axis tilt
C  CS  Feed to subreflector point
C  AA  Large axis of subreflector - total diameter
C  BB  Small axis of subreflector - total diameter
C
      CA=FOCAL*DIA/(DIA-SDIA)-SDIA*(COS(FPSI)+1.)/SIN(FPSI)/4.
      TILT=ATAN(2./((COS(FPSI)+1.)/SIN(FPSI)-4.*FOCAL/(DIA-SDIA)))
      FS=SDIA/(4.*SIN(TILT))
C  FS  is focal distance of ellipse
C      PSIM=ATAN(8.*FOCAL*(DIA-SDIA)/(16.*FOCAL**2)-(DIA-SDIA)**2)
	PSIM=2.*ATAN((DIA-SDIA)/4./FOCAL)
      CS=2.*FS*COS(TILT)+SDIA/(2.*TAN(PSIM))
      AA=SDIA*(COS(FPSI)+1.)/SIN(FPSI)/4.+FOCAL*SDIA/(DIA-SDIA)
      BB=SQRT(AA**2-(2.*FS)**2)
      RETURN
      END

      SUBROUTINE DACRP(DIA,FOCAL,SDIA,FPSI,DOFF,CA,TILT,CS,AA,TC,PSIM,
     1 DELTA)
C 
C  Displaced axis single offset Cassegrian subreflector geometry Granet's
C  formulas
C
C  A Simple Procedure for the Design of Classical Displaced-Axis 
C  Dual-reflectors using a set geometric parameters, IEEE AP Mag. Dec. 1999
C
C  by Christophe Granet
C 
C  Inputs:
C 
C  DIA  Main reflector diameter
C  FOCAL Focal length of main reflector
C  SDIA  Subreflector diameter
C  FPSI  Feed half subtended angle (radians)
C  DOFF  Axis offset distance
C 
C  Outputs:
C 
C  CA  Distance from main vertex to feed
C  TILT  Subreflector axis tilt
C  CS  Feed to subreflector point
C  AA  Subreflector twice distance from origin to curve
C  TC  Subreflector distance between hyperbola focuses
C  PSIM   Main reflector max feed angle from focus
C  DELTA  Main reflector min feed angle from focus
C
      DOF2=2.*DOFF
      PSIM=ATAN(8.*FOCAL*(DIA+DOF2)/(16.*FOCAL**2-(DIA+DOF2)**2))
C  CS (LS) Feed to subreflector
      CS=SDIA/2./SIN(FPSI)+(DIA-SDIA)/2./SIN(PSIM)
     1+((SDIA+DOF2)**2-(DIA+DOF2)**2)/16./FOCAL
     2-(16.*FOCAL**2*SDIA+SDIA*(SDIA+DOF2)**2)/16./FOCAL/(SDIA+DOF2)
      A=CS/2.-DOFF*(16.*FOCAL**2+(SDIA+DOF2)**2)/16./FOCAL/
     1(SDIA+DOF2)
      DELTA=ATAN(8.*FOCAL*(SDIA+DOF2)/(16.*FOCAL**2-(SDIA+DOF2)**2))
C  CA (LM) Feed to main reflector edge (not vertex)
      CA=(16.*FOCAL**2-(SDIA+DOF2)**2)/16./FOCAL-CS+(2.*A-CS)*COS(DELTA)
      TILT=-ATAN(DOFF/(CS+(CS-2.*A)*COS(DELTA)))
      TC=(CS+(CS-2.*A)*COS(DELTA))/COS(TILT)
      AA=2.*A
      RETURN
      END

      SUBROUTINE DDCRP(DIA,FOCAL,SDIA,FPSI,DOFF,CA,TILT,CS,AA,TC,PSIM,
     1 DELTA)
C 
C  Displaced axis dual offset Cassegrian subreflector geometry Granet's
C  formulas
C
C  A Simple Procedure for the Design of Classical Displaced-Axis 
C  Dual-reflectors using a set geometric parameters, IEEE AP Mag. Dec. 1999
C
C  by Christophe Granet
C 
C  Inputs:
C 
C  DIA  Main reflector diameter
C  FOCAL Focal length of main reflector
C  SDIA  Subreflector diameter
C  FPSI  Feed half subtended angle (radians)
C  DOFF  Axis offset distance
C 
C  Outputs:
C 
C  CA  Distance from main vertex to feed
C  TILT  Subreflector axis tilt
C  CS  Feed to subreflector point
C  AA  Subreflector twice distance from origin to curve
C  TC  Subreflector distance between hyperbola focuses
C  PSIM   Main reflector max feed angle from focus
C  DELTA  Main reflector min feed angle from focus
C
      DOF2=2.*DOFF
      PSIM=ATAN(8.*FOCAL*(DIA+SDIA+DOF2)/
     1 (16.*FOCAL**2-(DIA+SDIA+DOF2)**2))
C  CS (LS) Feed to subreflector
      CS=SDIA/2./SIN(FPSI)+SDIA*(4.*FOCAL**2+(SDIA+DOF2)**2)/
     1(4.*FOCAL*(SDIA+DOF2))-(SDIA+DOF2)**2/4./FOCAL-DIA/2./SIN(PSIM)
     2+(DIA+SDIA+DOF2)**2/16./FOCAL
      CS=(SDIA+DOF2)*((DIA+SDIA+DOF2)**2/16./FOCAL-FOCAL)/(DIA+SDIA
     1 +DOF2)+SDIA/2./TAN(FPSI)-DOFF*((SDIA+DOFF)**2/4./FOCAL-FOCAL)
     2/(SDIA+DOFF)
      A=SDIA/4./SIN(FPSI)-DOFF*(4.*FOCAL**2+(SDIA+DOFF)**2)/(8.*FOCAL
     1 *(SDIA+DOFF))
      DELTA=ATAN(4.*FOCAL*(SDIA+DOFF)/(4.*FOCAL**2-(SDIA+DOFF)**2))
C  CA (LM) Feed to main reflector edge (not vertex)
      CA=FOCAL-(SDIA+DOFF)**2/4./FOCAL+DOFF*((SDIA+DOFF)**2/4./FOCAL
     1 -FOCAL)/(SDIA+DOFF)-SDIA/2./TAN(FPSI)
      TILT=-ATAN(2.*FOCAL*(SDIA+DOF2)/(4.*FOCAL**2-(SDIA+DOFF)**2
     1 -4.*FOCAL*CA))
      TC=(4.*FOCAL**2-(SDIA+DOFF)**2-4.*FOCAL*CA)/4./FOCAL/COS(TILT)
      AA=2.*A
      RETURN
      END

      SUBROUTINE DAGRP(DIA,FOCAL,SDIA,FPSI,DOFF,CA,TILT,CS,AA,BB,PSIM,
     1 DELTA)
C 
C  Displaced axis dual offset Gregorian subreflector geometry Granet's
C  formulas
C
C  A Simple Procedure for the Design of Classical Displaced-Axis 
C  Dual-reflectors using a set geometric parameters, IEEE AP Mag. Dec. 1999
C
C  by Christophe Granet
C 
C  Inputs:
C 
C  DIA  Main reflector diameter
C  FOCAL Focal length of main reflector
C  SDIA  Subreflector diameter
C  FPSI  Feed half subtended angle (radians)
C  DOFF  Axis offset distance
C 
C  Outputs:
C 
C  CA  Distance from main vertex to feed
C  TILT  Subreflector axis tilt
C  CS  Feed to subreflector point
C  AA  Large axis of subreflector - total diameter
C  BB  Small axis of subreflector - total diameter
C  PSIM   Main reflector max feed angle from focus
C  DELTA  Main reflector min feed angle from focus
C
      DOF2=2.*DOFF
      PSIM=ATAN(8.*FOCAL*(DIA-DOF2)/(16.*FOCAL**2-(DIA-DOF2)**2))
C  CS (LS) Feed to subreflector
      TEM=DOFF*(16.*FOCAL**2+(SDIA-DOF2)**2)/(8.*FOCAL*(SDIA-DOF2))
      TEN=DOFF*(16.*FOCAL**2-(SDIA-DOF2)**2)/(8.*FOCAL*(SDIA-DOF2))
      CS=SDIA/2./SIN(FPSI)+(SDIA+DOF2)/SIN(PSIM)/2.-TEM
C  CA (LM) Feed to main reflector edge (not vertex)
      CA=FOCAL-(SDIA-DOF2)**2/16./FOCAL+TEN-CS
      AA=SDIA/SIN(FPSI)/2.+(SDIA+DOF2)/SIN(PSIM)/2.
      TILT=ATAN(DOFF/(CS-TEN))
      FS=DOFF/SIN(TILT)
C  FS  is 2*focal distance of ellipse
      BB=SQRT(AA**2-FS**2)
      DELTA=ATAN(DOFF/TEN)
      RETURN
      END

