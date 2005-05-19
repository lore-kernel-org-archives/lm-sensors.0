From: david.goodenough@btconnect.com (David Goodenough)
Date: Thu, 19 May 2005 06:25:56 +0000
Subject: Support of i2c-nscacb
Message-Id: <200505050024.56278.david.goodenough@btconnect.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <4263B107.1070703@buholzer.com>
In-Reply-To: <4263B107.1070703@buholzer.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Sorry, I forgot that you need to add some parameters.

scx200_acb base=0x810,0x820

David

On Wednesday 04 May 2005 23:19, Mirko Buholzer wrote:
> Hi David
>
> I had some additional time to work with my WRAP System. I am currently
> having troubles getting data from the LM77.
> I did the following tasks as described below. I assume that the lm77 is
> working properly. But I don't know why no data is transfered.
>
> Do you have any hint where I could start working?
>
> I appreciate any Help!
> Best Regards
> Miko
>
>
> ------
> # modprobe  scx200_acb
> # modprobe lm77
> # i2cdetect 1
>
>      0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f
> 00:          XX XX XX XX XX XX XX XX XX XX XX XX XX
> 10: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX
> 20: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX
> 30: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX
> 40: XX XX XX XX XX XX XX XX UU XX XX XX XX XX XX XX
> 50: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX
> 60: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX
> 70: XX XX XX XX XX XX XX XX
>
> # sensors
> lm77-i2c-0-48
> Adapter: SCx200 ACB0
>
>  # i2cdump 0 0x48
>      0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f    0123456789abcdef
> 00: 02 XX 00 XX 00 04 XX 04 XX 00 00 XX 00 04 XX 04    ?X.X.?X?X..X.?X?
> 10: XX 00 00 XX 00 04 XX 04 XX 00 00 XX 00 04 XX 04    X..X.?X?X..X.?X?
> 20: XX 00 00 XX 00 04 XX 04 XX 00 00 XX 00 04 XX 04    X..X.?X?X..X.?X?
> 30: XX 00 00 XX 00 04 XX 04 XX 00 00 XX 00 04 XX 04    X..X.?X?X..X.?X?
> 40: XX 00 00 XX 00 04 XX 04 XX 00 00 XX 00 04 XX 04    X..X.?X?X..X.?X?
> 50: XX 00 00 XX 00 04 XX 04 XX 00 00 XX 00 04 XX 04    X..X.?X?X..X.?X?
> 60: XX 00 00 XX 00 04 XX 04 XX 00 00 XX 00 04 XX 04    X..X.?X?X..X.?X?
> 70: XX 00 00 XX 00 04 XX 04 XX 00 00 XX 00 04 XX 04    X..X.?X?X..X.?X?
> 80: XX 00 00 XX 00 04 XX 04 XX 00 00 XX 00 04 XX 04    X..X.?X?X..X.?X?
> 90: XX 00 00 XX 00 04 XX 04 XX 00 00 XX 00 04 XX 04    X..X.?X?X..X.?X?
> a0: XX 00 00 XX 00 04 XX 04 XX 00 00 XX 00 04 XX 04    X..X.?X?X..X.?X?
> b0: XX 00 00 XX 00 04 XX 04 XX 00 00 XX 00 04 XX 04    X..X.?X?X..X.?X?
> c0: XX 00 00 XX 00 04 XX 04 XX 00 00 XX 00 04 XX 04    X..X.?X?X..X.?X?
> d0: XX 00 00 XX 00 04 XX 04 XX 00 00 XX 00 04 XX 04    X..X.?X?X..X.?X?
> e0: XX 00 00 XX 00 04 XX 04 XX 00 00 XX 00 04 XX 04    X..X.?X?X..X.?X?
> f0: XX 00 00 XX 00 04 XX 04 XX 00 00 XX 00 04 XX 04    X..X.?X?X..X.?X?
>
> David Goodenough wrote:
> >On Monday 18 April 2005 14:07, Mirko Buholzer wrote:
> >>Hi all
> >>
> >>I am new to this mailing list and also to the LM_Sensors package. I have
> >>a WRAP Embedded System (http://www.pcengines.ch/) which is based on the
> >>GEODE SC1100 and the i2c-nscacb.c driver from National. I saw, that
> >>there were some discussions in this mailing list about this driver 6
> >>months ago, but couldn't find further information about the support of
> >>this Bus Driver. Is there already some work going on or is there a way
> >>to contribute to enable this chip?
> >>
> >>Thanks in advance for any information!
> >>Best Regards
> >>Mirko
> >>
> >>BTW: How can I subscribe to this list?
> >
> >If you are using a 2.6 kernel then the scx200_acb driver is the one you
> >need.  The iscacb driver is obsolete.  The lm87 driver then does the
> >sensing.
> >
> >I am using it on several WRAP boards.
> >
> >David
