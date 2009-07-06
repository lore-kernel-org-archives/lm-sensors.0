From: Rudolf Marek <r.marek@assembler.cz>
Date: Mon, 06 Jul 2009 14:16:49 +0000
Subject: Re: [lm-sensors] Test of k8temp
Message-Id: <4A520751.3070803@assembler.cz>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi again,


 >Anyway, In the patch, replace :

 >+       /* Some AMD 10H cpus reports Inaccurate Temperature Measurement */
 >+       if ((temp < 21000) || (temp > 90000))

 >+       /* Some AMD 10H cpus reports Inaccurate Temperature Measurement */
 >+       if ((temp < 10000) || (temp > 90000))

So, now you see that workaround on some arbitrary temperature simply does not 
make sense.

Please don't add  support for fam10h CPUs. This is not a point of HW monitoring, 
to rule out  arbitrary temperatures.

I'm perfectly fine if you come up with a patch for fam 11h because the Errata 
seems to have vanished...

Rudolf

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
