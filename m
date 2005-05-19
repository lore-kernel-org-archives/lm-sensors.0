From: ishikawa@yk.rim.or.jp (Ishikawa)
Date: Thu, 19 May 2005 06:24:01 +0000
Subject: Compiling lm_sensors module with gcc 3.3. (A problem and
Message-Id: <3EF5FA09.AEEEFDC1@yk.rim.or.jp>
List-Id: <lm-sensors.vger.kernel.org>
References: <3EF4DD25.6000802@yk.rim.or.jp>
In-Reply-To: <3EF4DD25.6000802@yk.rim.or.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

"Mark M. Hoffman" wrote:
> 
> Hi:
> 
> * Mark D. Studebaker <mds@paradyne.com> [2003-06-22 10:51:35 -0400]:
> > would you please send us the entire output of 'make' so we can clean up the warnings. Thanks.
> 
> > Ishikawa wrote:
> > >
> > > Thank you for your quick response.
> > >
> > > I downloaded the Makefile and etc/config.c
> > > and retried compiling lm_sensors 2.7.0 using gcc 3.3.
>                                      ^^^^^
> 
> (mds - correct me if I'm wrong here)
> 
> If you're going to send the output of make, please get the latest
> CVS of everything (i2c and lm_sensors2) not just these two files.
> We've already cleaned up a lot of warnings.
> 

Aha, I didn't read this message before sending out the
make output.

Let me try this again after I pulled in the CVS files.


-- 
int main(void){int j 03;/*(c)2003 cishikawa. */
char t[] ="<CI> @abcdefghijklmnopqrstuvwxyz.,\n\"";
char *i ="g>qtCIuqivb,gCwe\np@.ietCIuqi\"tqkvv is>dnamz";
while(*i)((j+=strchr(t,*i++)-(int)t),(j%=sizeof t-1),
(putchar(t[j])));return 0;}/* under GPL */
