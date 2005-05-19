From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:05 +0000
Subject: Error during shutdown
Message-Id: <20030716144029.45a5d73f.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <200307160526.45022.dalek@exceedtech.net>
In-Reply-To: <200307160526.45022.dalek@exceedtech.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


> I installed lm_sensors and gkrellm onto my system and it works fine. 
> However when I shut my system down I get a error message.  It's gone
> pretty quick but this is what I could make out after several restarts.
>  /etc/init.d/lm_sensors 
> line 73  [: -ge: unary operator expected.  I have uninstalled and
> reinstalled the lm_sensors package to see if it was just a glitch.  I
> even deleted the files a re-ran sensors-detect.  It still does it. 
> Any help would be appreciated.  I have attached a copy of the file.  

This script comes with your Mandrake 9.1 distribution, so the error is
theirs, not ours. However, I think I know how to fix it. Go to line 72
and replace
  i=`expr $Pmodules`
with
  i=$modules

Please try this and tell me how it goes.

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
