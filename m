From: phil@netroedge.com (phil@netroedge.com)
Date: Thu, 19 May 2005 06:23:36 +0000
Subject: [mayoff@dqd.com: Re: [ltp] Incorporating Thinkpad Detection into Lm_sensors]
Message-Id: <20020721133831.A11600@Stimpy.netroedge.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


Here's a response to a plea for help on the linux-thinkpad list:



----- Forwarded message from Rob Mayoff <mayoff@dqd.com> -----

Delivered-To: linux-thinkpad-outgoing@www.bm-soft.com
Delivered-To: linux-thinkpad@www.bm-soft.com
Date: 20 Jul 2002 20:17:26 -0500
From: "Rob Mayoff" <mayoff@dqd.com>
To: linux-thinkpad@www.bm-soft.com
Cc: phil@netroedge.com
Subject: Re: [ltp] Incorporating Thinkpad Detection into Lm_sensors
In-Reply-To: <20020720160329.K1076@Stimpy.netroedge.com>
Precedence: bulk
Reply-To: linux-thinkpad@www.bm-soft.com
X-SpamBouncer: 1.6 beta (6/22/02)
X-SBNote: FROM_DAEMON/Listserv
X-SBClass: Bulk

+---------- On Jul 20, phil@netroedge.com said:
> So, I need your help!  How can we detect a Thinkpad?  Does the PCI bus
> (lspci) give some obvious determination?  Or, is there some other
> means of detection we could use?  If we could detect for a Thinkpad,
> we could safely disable choice drivers to prevent any chance of Flash
> ROM corruption on those Thinkpads which are vulnerable.

Perhaps you could detect the "SMAPI BIOS", which many (possibly all)
Thinkpads appear to use. See Appendix B of the Technical Reference
Manual for the Thinkpad 600 or Thinkpad 770. If you search for "thinkpad
technical reference" on Google, those documents will be the top two
links.

Here's a quote:

    Systems that support SMAPI BIOS must provide the following header
    image in the F000 segment system ROM area at the 16-byte boundary.
    The client needs to search and find this SMAPI BIOS header image to
    get the entry point for the service.

    Field      Offset (in Hex)  Length   Value
    Signature  00               4 bytes  '$SMB' (ASCII)
    [etc...]

You might find the loadable modules in the tpctl package useful; they
use SMAPI. See <http://tpctl.sourceforge.net/tpctlhome.htm>.




----- The Linux ThinkPad mailing list -----
The linux-thinkpad mailing list home page is at:
http://www.bm-soft.com/~bm/tp_mailing.html

----- End forwarded message -----

-- 
Philip Edelbrock -- IS Manager -- Edge Design, Corvallis, OR
   phil@netroedge.com -- http://www.netroedge.com/~phil
 PGP F16: 01 D2 FD 01 B5 46 F4 F0  3A 8B 9D 7E 14 7F FB 7A
