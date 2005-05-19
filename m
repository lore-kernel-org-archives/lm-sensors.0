From: cli@aproimage.com (Calvin Li)
Date: Thu, 19 May 2005 06:23:40 +0000
Subject: Regarding ticket #1003
Message-Id: <004c01c26338$43bbe160$fb00a8c0@cli>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi,

I got the reply from support on ticket #1003 ( FSCPOS does not give
temperature reading ).

I did a OS re-install ( Red Hat 7.3, 2.4.18-3 ).
I changed the Makefile for i2c-2.6.5 :
LINUX=/usr/src/linux-2.4.18-3   ( originally, it was LINUX=/usr/src/linux ).

After " make all " , I got some error messages ( 12 same messages at 2
occations )
" /usr/src/linux-2.4.18-3/.config : no such file or directory ".

there is a directory " /usr/src/linux-2.4.18-3/configs ", is it realted ?

What did I do wrong?

Regards,

Please Email me : cli@aproimage.com

Calvin
