From: juergh@gmail.com (Juerg Haefliger)
Date: Tue, 09 Jan 2007 13:28:25 +0000
Subject: [lm-sensors] HP Compaq ProLiant DL380 detect failure
Message-Id: <191fb4ca0701090528h6c416c3w80e6d46071715ce6@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <4568C502.6070305@lymenet.org>
In-Reply-To: <4568C502.6070305@lymenet.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

I contacted the iLO ASIC guys and they are checking the request for
providing technical information. I also checked the schematics of the
DL385G2. The iLO ASIC provides 4 I2C buses to which the temp sensors
(SMSC EMC1043) are attached to.
I already wrote the driver for the EMC1043 and have a framework in
place for the iLO driver. More later...

...juerg


On 12/26/06, Thomas Brown <twb0 at lymenet.org> wrote:
> Thanks all--if we can get this working there is a large community of HP
> ProLiant server users who will benefit.
>
> Upon tracing the "hplog" process behavior, it seems to read the data is
> by using message queues attached to the Proliant System Health Monitor
> (hpasmd) process which, in turn, may also rely on data from the HP
> Lights-Out Drivers and Agents (hprsm) daemon.
>
> There are two routes that might be taken here:
>
> 1.  Reverse-engineer the hpasmd process and read values directly from
> the HP/Compaq hardware.
>    or
> 2.  Write a shim to work in concert with an existing hpasmd process and
> feed data back using existing drivers (i.e. /dev/cpqhealth/proc,
> /dev/cpqhealth/cevt, etc.)
>
> -Tom
>

