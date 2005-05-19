From: mds@paradyne.com (Mark D. Studebaker)
Date: Thu, 19 May 2005 06:23:29 +0000
Subject: ticket #814
Message-Id: <3C6578A3.9F16ADF2@paradyne.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20020209193900.B22573@shurdeek.cb.ac.at>
In-Reply-To: <20020209193900.B22573@shurdeek.cb.ac.at>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

looks like a 735 which we will add to the blacklist.
Please send 'lspci -n' to verify ID's.
thanks

Peter Surda wrote:
> 
> Hi!
> 
> Yes, you are right, it's a 2.6.2, not 2.5.2, I noticed the typo about 1 second
> after clicking on "send".
> 
> It could be indeed that it's unsupported, but I saw some postings about
> lmsensors working on this motherboard so I was hoping :-) It's a nice mobo and
> I got everything else working...
> 
> In case it's unsupported, what can I do to help?
> 
> So here's a a lspci -vv:
> 
> 00:00.0 Host bridge: Silicon Integrated Systems [SiS]: Unknown device 0735 (rev 01)
>         Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
>         Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort+ >SERR- <PERR-
>         Latency: 32
>         Region 0: Memory at d0000000 (32-bit, non-prefetchable) [sizedM]
>         Capabilities: [c0] AGP version 2.0
>                 Status: RQ1 SBA+ 64bit- FW- Rate=x1,x2
>                 Command: RQ=0 SBA+ AGP+ 64bit- FW- Rate=x1
> 
>    Part 1.2Type: application/pgp-signature
