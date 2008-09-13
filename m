From: Marco Chiappero <marco@absence.it>
Date: Sat, 13 Sep 2008 15:43:46 +0000
Subject: Re: [lm-sensors] New Asus board and multiple sensors chips
Message-Id: <48CBDFB2.2040304@absence.it>
List-Id: <lm-sensors.vger.kernel.org>
References: <48CA5C05.8040307@absence.it>
In-Reply-To: <48CA5C05.8040307@absence.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Marco Chiappero ha scritto:
> Now, in this board the first one has been replaced by the new Winbond
> W83667HG and it works thank to the trick of loading the w83627ehf driver
> with the force_id=0x8860 option (but a its own driver is on the way,
> right?). Starting from kernel 2.6.26 the coretemp driver works fine, but
> my cpu isn't recognized by sensors-detect ("Sorry, no sensors were
> detected", with lm-sensors 3.0.0) probably because I own a brand new
> E8600 Intel CPU which is a E0 revision. I haven't tried lm-sensors 3.0.2
> though.
> For what concerns the other two sensors chips I can modprobe the
> w83781, w83791d, w83792d, w83793 and adt7473 modules but running sensors
> or sensors-detect shows no new sensors at all. Unfortunately adt7475
> driver is not the upstream kernels yet.

Having some spare time I gave a try to the lastest sensors-detect 
patched for the w83667hg and both the coretemp and the new winbond chip 
are now detected. I also compiled the adt7475 driver, it loads fine but 
no sensors are show/discovered. Maybe is a specific address needed?


Marco Chiappero

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
