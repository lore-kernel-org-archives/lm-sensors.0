From: m9841@iijmio-mail.jp (M9841)
Date: Thu, 19 May 2005 06:24:09 +0000
Subject: Tickets #1350
Message-Id: <20030801172230.6479.M9841@iijmio-mail.jp>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

I am thankful for Alexander Amalysh and Mark M. Hoffman.
This is the second reply of ticket #1350.
I could solve the problem.
But now, sensors-detect(cvs version) says syntax error.

# sensors-detect
syntax error at /usr/local/sbin/sensors-detect line 2604, near ")
  push"
Execution of /usr/local/sbin/sensors-detect aborted due to compilation errors.

> 
> OK folks, we have Alexander Amalysh and Mark M. Hoffman working on the
> problem. There's a preliminary fix that has been commited to CVS, feel
> free to give it a try. It will possibly raise other problems, and as
> such is probably not the definitive fix.
> 
> We'll let you know as soon as a new fix is available.
> 
> -- 
> Jean Delvare
> http://www.ensicaen.ismra.fr/~delvare/


M9841 <m9841@iijmio-mail.jp>

