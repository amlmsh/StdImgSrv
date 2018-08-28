#########################################################################
# FILE NAME Makefile
#           copyright 2006 by University of Wales Aberystwyth
#
# BRIEF MODULE DESCRIPTION
#           Makefile for the standard image server 
#
# History:
#
#  01.09.2009 - initial version 
#
#
#########################################################################

CC = g++


CFLAGS=$(shell kg-config --cflags opencv) 
LIBS=$(shell pkg-config --libs opencv) 



TARGETS = stdImgDataServerSim  testClient stdImgDataServerLapCam stdImgDataServerClientColorFilter

all:	$(TARGETS)


Socket.o:	Socket.C
	$(CC) $(INCL) -g -DLINUX -D__LINUX__ -DUNIX -c $<

stdImgDataServerSim.o:	stdImgDataServerSim.C  StdImgDataServerProtocol.H
	$(CC) $(INCL)   -g -DLINUX -D__LINUX__ -DUNIX -D_REENTRANT -c $<

stdImgDataServerLapCam.o:	stdImgDataServerLapCam.C  StdImgDataServerProtocol.H
	$(CC) $(INCL)   -g -DLINUX -D__LINUX__ -DUNIX -D_REENTRANT -c $<

stdImgDataServerClientColorFilter.o:	stdImgDataServerClientColorFilter.C  StdImgDataServerProtocol.H
	$(CC) $(INCL)   -g -DLINUX -D__LINUX__ -DUNIX -D_REENTRANT -c $<

testClient.o:	testClient.C  StdImgDataServerProtocol.H
	$(CC) $(INCL)   -g -DLINUX -D__LINUX__ -DUNIX -D_REENTRANT   -c $<

stdImgDataServerSim: Socket.o stdImgDataServerSim.o StdImgDataServerProtocol.H
	$(CC) $(INCL) -I/usr/local/lib   \
	-lpthread -D_REENTRANT \
	-lm -lstdc++  Socket.o  -lpthread \
	stdImgDataServerSim.o -o stdImgDataServerSim
	
stdImgDataServerLapCam: Socket.o stdImgDataServerLapCam.o StdImgDataServerProtocol.H
	$(CC) stdImgDataServerLapCam.o -o stdImgDataServerLapCam   \
	$(LIBS) -lpthread -D_REENTRANT \
	-lm -lstdc++  Socket.o  -lpthread  
		

stdImgDataServerClientColorFilter: Socket.o stdImgDataServerClientColorFilter.o StdImgDataServerProtocol.H
	$(CC) stdImgDataServerClientColorFilter.o -o stdImgDataServerClientColorFilter   \
	$(LIBS) -lpthread -D_REENTRANT \
	-lm -lstdc++  Socket.o  -lpthread 

testClient: testClient.o Socket.o testClient.C StdImgDataServerProtocol.H
	$(CC)  testClient.o Socket.o -o testClient $(LIBS) -ldl -lstdc++ -lm -std=c++11 \
	



#cleaning up
clean:
	rm -r *.o  $(TARGETS)
