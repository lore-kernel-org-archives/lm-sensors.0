From: Jean Delvare <khali@linux-fr.org>
Date: Mon, 09 Sep 2013 06:44:00 +0000
Subject: Re: [lm-sensors] Whats wrong with LM-Sensors
Message-Id: <20130909084400.3e4afaa7@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <!&!AAAAAAAAAAAYAAAAAAAAAGE4UvMgtwJIpJJKF65P6VPCgAAAEAAAAEchc8MJx35LlZC8CEJITyEBAAAAAA==@tlec.se>
In-Reply-To: <!&!AAAAAAAAAAAYAAAAAAAAAGE4UvMgtwJIpJJKF65P6VPCgAAAEAAAAEchc8MJx35LlZC8CEJITyEBAAAAAA==@tlec.se>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Sun, 8 Sep 2013 23:28:11 +0200, Tomas Larsson wrote:
> On the Centos 6 mashine, I obviously don't get any fan-speed though.

I would just boot with acpi_enforce_resources=lax. I do not usually
recommend this, but given that you are already doing that on your
Centos 5 machines (because the resource conflict check was not
implemented at that time) you might as well do it on all machines.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
