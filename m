From: Jean Delvare <khali@linux-fr.org>
Date: Mon, 10 Dec 2007 15:01:46 +0000
Subject: Re: [lm-sensors] Intel Core voltage monitoring
Message-Id: <20071210160146.01be0bf2@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <475BDA45.70400@googlemail.com>
In-Reply-To: <475BDA45.70400@googlemail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Mon, 10 Dec 2007 15:50:26 +0100, Jean Delvare wrote:
> Your sensors-detect output doesn't include the SMBus scan, I guess that
> the SMBus is hidden. I've seen this before on Toshiba laptops, and
> after investigation we found that the SMBus was being accessed by SMM
> code, so it's not safe to let Linux access it. That's a design decision
> by the manufacturer, there's nothing we can do. You might be able to
> get the fan reading using the toshiba_acpi driver, but that's about it.

Forgot the references if you want to read the technical details:
http://bugzilla.kernel.org/show_bug.cgi?idc15
http://bugzilla.kernel.org/show_bug.cgi?idc95

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
