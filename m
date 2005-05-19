From: s.roa@computer.org (Sergio Roa Ovalle)
Date: Thu, 19 May 2005 06:24:05 +0000
Subject: error compiling with i2c 2.8.0 patch
Message-Id: <m3lluw6g3g.fsf@athlon.familiaroa>
List-Id: <lm-sensors.vger.kernel.org>
References: <m3oeztep4f.fsf@athlon.familiaroa>
In-Reply-To: <m3oeztep4f.fsf@athlon.familiaroa>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Jean Delvare escribi? (Thu, 17 Jul 2003 09:06:15 +0200):

    >> I have SuSE 8.0 with kernel 2.4.18.  I am trying to use the i2c patch,
    >> in order  to use my webcam  (module bttv) and lm_sensors.  I have used
    >> the mkpatch  script which comes  with the i2c  package. When I  try to
    >> compile the kernel I get the following errors for various i2c modules:
    >> (...)

    JD> Could  you send  us your  .config file?  I could  then  try to
    JD> reproduce the problem on my system.

Ok.

    JD> However, why are  you using such an old  kernel? It's 17 month
    JD> and three  version old! If  you are to recompile  your kernel,
    JD> you should update to 2.4.21 before doing so, methinks.

    >> Besides I am not  sure if the file i2c-2.8.0-drivers-media-video.diff,
    >> which I also used for patching, is appropriate for my kernel.

    JD> If it applied cleanly (I mean not part was rejected) it should
    JD> be OK.

Hmm, I think it  will not be OK... :( Some parts  were rejected. Now I
am thinking in updating the kernel, although I didn't really want.

Thanks.

-- 
Sergio Roa Ovalle
Key fingerprint = 5427 E535 8E18 8B3B C38B  ADB5 9DF5 89DE FBF4 738C
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config
Type: application/octet-stream
Size: 40799 bytes
Desc: .config
Url : http://lists.lm-sensors.org/pipermail/lm-sensors/attachments/20030717/8203097f/config.obj
