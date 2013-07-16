From: Jean Delvare <khali@linux-fr.org>
Date: Tue, 16 Jul 2013 15:19:38 +0000
Subject: Re: [lm-sensors] Fwd: Fintek F71868AD
Message-Id: <20130716171938.0f300109@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <D9374150-2C98-4C2C-85F4-063795B64EB4@ifreemans.org>
In-Reply-To: <D9374150-2C98-4C2C-85F4-063795B64EB4@ifreemans.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Sun, 7 Jul 2013 18:39:24 -0700, Brock Freeman wrote:
> Some people are looking for the data sheet for the Fintek F71868AD. I contacted Fintek and they replied in < 30 minutes with the data sheet I have put at https://dl.dropboxusercontent.com/u/1364641/F71868A_V0.15P.pdf.

Thanks Brock, this is very useful.

Hans, I have added detection to sensors-detect. Can you download the
datasheet and check if this chip is compatible enough to be supported
by your f71882fg driver or not? It is definitely not compatible with my
f71805f driver.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
