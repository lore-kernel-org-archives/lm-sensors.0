From: khali@linux-fr.org (Jean Delvare)
Date: Wed, 21 Feb 2007 16:17:37 +0000
Subject: [lm-sensors] Could the k8temp driver be interfering with ACPI?
Message-Id: <20070221171737.b6592104.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <45D5EA88.7090300@redhat.com>
	<45D6DDCE.5050803@assembler.cz>
	<45D7461A.2040808@redhat.com>
	<45D8D6AE.3000204@assembler.cz>
	<45DB0EEA.2010205@redhat.com>
	<20070220191142.GE16614@redhat.com>
In-Reply-To: <20070220191142.GE16614@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Dave Jones <davej@redhat.com>
Cc: Chuck Ebbert <cebbert@redhat.com>, linux-acpi@vger.kernel.org, linux-kernel <linux-kernel@vger.kernel.org>, lm-sensors@lm-sensors.org

On Tue, 20 Feb 2007 14:11:42 -0500, Dave Jones wrote:
> On Tue, Feb 20, 2007 at 10:08:26AM -0500, Chuck Ebbert wrote:
>  
>  > 	i2c_core
>  > 	i2c_ec
>  > 	i2c_piix4
>  > 	asus_acpi (on a Compaq???)
>  > 	sbs
> 
> Something is pulling in asus_acpi as a dependancy. I've never
> figured out what the cause is.  For a long time I was thinking
> that we had an explicit modprobe for it in an initscript, but
> grepping for it in /etc turns up zip.

How could it be, given that asus_acpi doesn't export any symbol?

-- 
Jean Delvare

