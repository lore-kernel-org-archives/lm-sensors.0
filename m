From: Jean Delvare <khali@linux-fr.org>
Date: Mon, 12 Oct 2009 13:40:59 +0000
Subject: Re: [lm-sensors] [PATCH] coretemp: Add Lynnfield CPU
Message-Id: <20091012154059.56b654e4@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <20090915021341.GA14957@owl>
In-Reply-To: <20090915021341.GA14957@owl>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Kent,

On Sat, 10 Oct 2009 14:01:18 +0800, Kent Liu wrote:
> Yes. I think Huaxu and I can take this, even though I am still on the way 
> to acquire enough documents from hardware team. As I have a lot of processors
> on hand to test, maybe it's better to gain more coverage in coretemp driver.
> 
> Please let me know what I need to do regarding to take the maintainership.
> We are not experienced in doing so.

Simply send us a patch updating the "CORETEMP HARDWARE MONITORING
DRIVER" entry in file MAINTAINERS. Set the M: field to the new
maintainer (format is "name <address>"). You can have several M: fields
if there will be several maintainers. And that's all :)

Once we receive the patch, I'll pick it and push it upstream in a
timely manner.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
