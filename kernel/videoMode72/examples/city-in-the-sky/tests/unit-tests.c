
// A unit test returns 0 if it passes, or a reason if it fails via an assertion
#define assert(message, test) do { if (!(test)) return message; } while (0)
#define run_test(test) do { char *message = test(); tests_run++; if (message) return message; } while (0)
 
 