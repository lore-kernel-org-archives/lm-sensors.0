From: Rudolf Marek <rudolf.marek@sysgo.com>
Date: Tue, 04 Sep 2007 18:53:43 +0000
Subject: Re: [lm-sensors] k8temp, BE-2350 CPU
Message-Id: <46DDA9B7.8000701@sysgo.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <46BAABD3.5000103@assembler.cz>
In-Reply-To: <46BAABD3.5000103@assembler.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Bernhard,

+static u32 convert_rev_f(u32 val)
+{
+	return (((((val) >> 16) & 0xff) - 49) * 1000);
+}
+
+static u32 convert_rev_g(u32 val)
+{
+	return (((((val) >> 14) & 0x3ff) - 49) * 250);
+}

Are you sure those are correct? The datasheets suggest that you need first
extract the 0.25 degC from two lowest bits and THEN subtract 49.

Your code does it first. Your method will work only if AMD made a mistake in
documentation. Are you sure?

Thanks,

Rudolf


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
