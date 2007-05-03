From: Rudolf Marek <r.marek@assembler.cz>
Date: Thu, 03 May 2007 16:15:49 +0000
Subject: Re: [lm-sensors] sensors-detect failed !
Message-Id: <463A0AB5.7090009@assembler.cz>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi there too,

You need 2.6.21, then load the w83627ehf driver again. Your revision of this
chip is DHG at the end and it is supported in 2.6.21. L78 is misdetection. You
may also check or Devices page for a patch for earlier kernels

Rudolf

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
