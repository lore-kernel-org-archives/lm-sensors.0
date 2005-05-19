From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:12 +0000
Subject: need some information
Message-Id: <20030811184349.5b66d504.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org



> I want to monitor my cpu temp, so i checked out some dockapps said to
> do this. they all needed lm_sensors to work, so i went to your site.
>  
> But there i read that 2.4 kernels had this function built in.

Where the hell did you read that? It's plain wrong. 2.4 kernels do *not*
have any hardware monitoring device drivers included.

> Im using 2.4.20 and ask. should i download lm_sensors and I2C? or is
> it ok to go ahead and download the dockapp?

You will need i2c and lm_sensors (in that order). Also, make sure it
works OK before using the dockapp.

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
