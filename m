From: Jean-Philippe Orsini <jeanfi@gmail.com>
Date: Sun, 28 Nov 2010 11:49:24 +0000
Subject: Re: [lm-sensors] how to rename sensor variables
Message-Id: <4CF241C4.9010105@gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <771591.69512.qm@web111709.mail.gq1.yahoo.com>
In-Reply-To: <771591.69512.qm@web111709.mail.gq1.yahoo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On 11/28/2010 08:39 AM, Mahmood Naderan wrote:
> There is nothing about k10temp in sensors3.conf.
I guess you can add an entry in the configuration file, something like:

chip "k10temp-pci-*"
	label temp1 "CPU0"
	label temp2 "CPU1"
	ignore temp3

man sensors.conf should give you more information.

Regards,
                   JeanFI.

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
