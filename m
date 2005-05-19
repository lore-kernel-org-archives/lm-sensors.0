From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:25:18 +0000
Subject: Parsing bug fixed in i2c-proc
Message-Id: <20041012222850.23dc6c15.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi all,

Yesterday I spotted an odd bug in i2c-proc. The parsing code for reals
is broken. It doesn't properly "eat" extra characters after values. The
part of the code which supposedly does this is:

       /* Skip everything until we hit whitespace */
       while (bufsize && 
              !((ret=get_user(nextchar, (char *) buffer))) &&
              isspace((int) nextchar)) {
               bufsize--;
               ((char *) buffer)++;
       }

It actually does the exact contrary, i.e. skip everyting until we hit
*non* whitespace.

You can reproduce the bug by trying to write "70.55" to a procfs
temperature file with magnitude 1. The first limit (typically max) will
be set to 70.5, which is fine. The second limit (typically min or hyst)
will be set to 5, which you certainly wouldn't expect.

I just commited the fix to the CVS repository. It is as simple as:

-              isspace((int) nextchar)) {
+              !isspace((int) nextchar)) {

I am a bit surprised that this bug seems to be there for several years
and nobody ever hit it. Thus, I would appreciate if someone else could
verify, test and confirm.

I will send a patch to Marcelo for Linux 2.4.

Thanks.

-- 
Jean Delvare
http://khali.linux-fr.org/
