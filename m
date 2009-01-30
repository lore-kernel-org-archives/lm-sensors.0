From: Jean Delvare <khali@linux-fr.org>
Date: Fri, 30 Jan 2009 11:06:09 +0000
Subject: Re: [lm-sensors] PATCH:
Message-Id: <20090130120609.1f8d942b@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <46F3DD44.4070307@hhs.nl>
In-Reply-To: <46F3DD44.4070307@hhs.nl>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Fri, 30 Jan 2009 11:29:47 +0100, Hans de Goede wrote:
> Hi Jean,
> 
> <Trying to win the competition for the patch with the longest name :) >
> 
> This patch fixes a number of cases where things were not properly cleaned up
> when acpi_check_resource_conflict() returned an error, causing oopses such as
> the one reported here:
> https://bugzilla.redhat.com/show_bug.cgi?idH3208
> 
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>

Applied, thanks.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
