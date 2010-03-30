From: Matthew Garrett <mjg59@srcf.ucam.org>
Date: Tue, 30 Mar 2010 13:21:32 +0000
Subject: Re: [lm-sensors] [PATCH] hwmon: (asus_atk0110) Don't load if
Message-Id: <20100330132132.GA16657@srcf.ucam.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <20100309135636.373a40a9@hyperion.delvare> <20100330120319.627e8f9a@hyperion.delvare>
In-Reply-To: <20100330120319.627e8f9a@hyperion.delvare>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Jean Delvare <khali@linux-fr.org>
Cc: linux-acpi@vger.kernel.org, LM Sensors <lm-sensors@lm-sensors.org>, Len Brown <lenb@kernel.org>

On Tue, Mar 30, 2010 at 12:03:19PM +0200, Jean Delvare wrote:
> ACPI people,
> 
> Do you have any objection to the patch below, or can I push it upstream?

If you pass that boot option, you're already indicating that you don't 
care about multiple things accessing the same resources simultaneously. 
I think it's reasonable to leave things up to the user to configure at 
that point.

-- 
Matthew Garrett | mjg59@srcf.ucam.org

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
