From: salahx@yahoo.com (Salah Coronya)
Date: Wed, 05 Oct 2005 06:14:50 +0000
Subject: [lm-sensors] [PATCH] hwmon: Cleanup w83627hf initialization
Message-Id: <43435306.9040308@yahoo.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20051004200848.5f4f0182.khali@linux-fr.org>
In-Reply-To: <20051004200848.5f4f0182.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Jean Delvare wrote:
> Hi all,
> 
> I am enqueuing the following patch. I would appreciate if owners of a
> W83627HF chip could give it a try and confirm that PWM2 still works OK.


It works for me just fine, actually it works BETTER. before pwm1 and 
pwm2 were reversed (pwm1 controlled fan2; and pwm2 controller fan1), and 
the fan2 would always report 0 no matter what the fan speed was. Now the 
reading and controls are correct, or at least more plausible. (Unless it 
was another patch between 2.6.13 and 2.6.13-r3).
