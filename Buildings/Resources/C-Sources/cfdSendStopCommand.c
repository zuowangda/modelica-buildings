///////////////////////////////////////////////////////////////////////////////
///
/// \file   cfdSendStopCommand.c
///
/// \brief  Function to send a stop command to terminate the CFD simulation
///
/// \author Wangda Zuo
///         University of Miami
///         W.Zuo@miami.edu
///
/// \date   8/3/2013
///
///////////////////////////////////////////////////////////////////////////////
#include "cfdCosimulation.h"

///////////////////////////////////////////////////////////////////////////////
/// Send a stop command to terminate the CFD simulation
///
///\return No return needed
///////////////////////////////////////////////////////////////////////////////
void cfdSendStopCommand( ) {
  cosim->para->flag = 0;
  printf("sendStopCommand( ): Set cosim->para->flag = %d\n", 
         cosim->para->flag);
} // End of cfdSendStopCommand 