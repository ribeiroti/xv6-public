// Set tickets to a process
// must be reparented at exit.

#include "types.h"
#include "stat.h"
#include "user.h"

int
main(void)
{
  settickets();
  exit();
}

