From: zdavatz@ywesee.com (Zeno R.R. Davatz)
Date: Thu, 19 May 2005 06:24:10 +0000
Subject: failed again; vetctor 300
Message-Id: <20030806155245.70fbedd6.zdavatz@ywesee.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20030805222340.3799d819.zdavatz@ywesee.com>
In-Reply-To: <20030805222340.3799d819.zdavatz@ywesee.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Wed, 6 Aug 2003 15:21:17 +0200
Jean Delvare <khali@linux-fr.org> wrote:

> 
> > Ok, done that. Now I get this:
> > gcc -I. -Ikernel/include -I/usr/local/include
> > -I/lib/modules/2.4.21-ben2/build/include  -Wall -O2   -c lib/data.c -o
> > lib/data.ao In file included from lib/data.c:20:
> > /usr/include/stdlib.h:445: error: Syntaxfehler before "int32_t"
> > /usr/include/stdlib.h:447: error: Syntaxfehler before '*' token
> > /usr/include/stdlib.h:451: error: Syntaxfehler before '*' token
> > /usr/include/stdlib.h:452: error: Syntaxfehler before '}' token
> > /usr/include/stdlib.h:455: error: Syntaxfehler before "int32_t"
> > lib/data.c: In function `sensors_parse_chip_name':
> > lib/data.c:117: Warnung: deprecated use of label at end of compound
> > statement
> > lib/data.c:151: Warnung: deprecated use of label at end of
> > compound statement
> > make: *** [lib/data.ao] Fehler 1
> > 
> > Any hints?
> 
> Not really. Didn't you encounter this problem with lm_sensors 2.8.0?
Can't remember, could be.
 
> The warnings are harmless, you can get the fixed version of the file
> here if you want.
> http://www2.lm-sensors.nu/~lm78/cvs/lm_sensors2/lib/data.c
Done this to /usr/src/modules/lm-sensors/lib

. Still get:
-I /usr/lib/gcc-lib/powerpc-linux/3.3.1/include  -Wall -O2   -c kernel/chips/vt1211.c -o kernel/chips/vt1211.o
gcc -I. -Ikernel/include -I/usr/local/include -I/lib/modules/2.4.21-ben2/build/include  -Wall -O2   -c lib/data.c -o lib/data.ao
In file included from lib/data.c:20:
/usr/include/stdlib.h:445: error: Syntaxfehler before "int32_t"
/usr/include/stdlib.h:447: error: Syntaxfehler before '*' token
/usr/include/stdlib.h:451: error: Syntaxfehler before '*' token
/usr/include/stdlib.h:452: error: Syntaxfehler before '}' token
/usr/include/stdlib.h:455: error: Syntaxfehler before "int32_t"
make: *** [lib/data.ao] Fehler 1


> Sounds like a broken system header, which won't let you compile the
> library nor any user-space program.
> 
> What's there in /usr/include/stdlib.h, lines 430 to 460?
extern char *initstate (unsigned int __seed, char *__statebuf,
                        size_t __statelen) __THROW;

/* Switch the random number generator to state buffer STATEBUF,
   which should have been previously initialized by `initstate'.  */
extern char *setstate (char *__statebuf) __THROW;


# ifdef __USE_MISC
/* Reentrant versions of the `random' family of functions.
   These functions all use the following data structure to contain
   state, rather than global state variables.  */

struct random_data
  {
    int32_t *fptr;              /* Front pointer.  */
    int32_t *rptr;              /* Rear pointer.  */
    int32_t *state;             /* Array of state values.  */
    int rand_type;              /* Type of random number generator.  */
    int rand_deg;               /* Degree of random number generator.  */
    int rand_sep;               /* Distance between front and rear.  */
    int32_t *end_ptr;           /* Pointer behind state table.  */
  };

extern int random_r (struct random_data *__restrict __buf,
                     int32_t *__restrict __result) __THROW;

extern int srandom_r (unsigned int __seed, struct random_data *__buf) __THROW;

extern int initstate_r (unsigned int __seed, char *__restrict __statebuf,
                        size_t __statelen,
                        struct random_data *__restrict __buf) __THROW;

Thanks for any Feedback.

Zeno
