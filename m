From: "Mark E. Hansen" <meh@Winfirst.Com>
Date: Mon, 05 Jan 2009 23:38:18 +0000
Subject: Re: [lm-sensors] Asus KFN4-DRE board
Message-Id: <496299EA.3080406@Winfirst.Com>
List-Id: <lm-sensors.vger.kernel.org>
References: <gjtlg7$htb$1@ger.gmane.org>
In-Reply-To: <gjtlg7$htb$1@ger.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On 01/05/09 14:10, Mark Nienberg wrote:
> Luca Tettamanti wrote:
> 
>> I'd like to see whether the board supports the ATK ACPI interface or not.
> 
> I sent the DSDT to Luca off list but "unfortunately there's no trace of the ATK 
> interface".
> 
> So I'm still looking for a temperature solution.  Is it safe to assume that since 
> Temp2 and Temp3 have the same limits then they must be the two CPU temps?  I did not 
> set any temperature limits in the "sensors.conf" file.
> 
> Thanks,
> 
> Mark
> 

You could just work the CPU and see which temps go up. Someone suggested this
earlier on this or another board, and I found it quite helpful in getting the
temps straightened out.

for example:

  md5sum /dev/zero


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
