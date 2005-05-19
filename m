From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:25:41 +0000
Subject: lm_sensors question: sensors-detect
Message-Id: <20050306212443.5d2edd73.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <200503040134.18474.chrisf@iquest.net>
In-Reply-To: <200503040134.18474.chrisf@iquest.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hello,

> When I run sensors-detect I get the following error:
> 
> Can't exec "i2cdetect": No such file or directory 
> at ../../prog/detect/sensors-detect line 4829, <STDIN> line 2.
> 
> I've looked through the documentation and couldn't find reference to
> this  error. I also did a scan of my hard drive and could not find the
> file.
> 
> Any help would be appreciated.

You are probably trying to run sensors-detect directly from the
lm_sensors source directory, but have not compiled it before. i2cdetect
is part of lm_sensors. You need to compile it (use "make user"), then
install user-space tools ("make user_install"). Then sensors-detect
should work.

If you really don't want to install the user-space tools, you can
instead add "." (current directory) to your $PATH, and move into
prog/detect before running ./sensors-detect. Note that you still need to
compile i2cdetect before you do.

Hope that helps,
-- 
Jean Delvare
