From: Alistair John Strachan <alistair@devzero.co.uk>
Date: Tue, 13 Jan 2009 16:56:36 +0000
Subject: [lm-sensors] [PATCH 0/2] hwmon: (abituguru3) Partial DMI matching,
Message-Id: <1231865798-12187-1-git-send-email-alistair@devzero.co.uk>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

These patches have been compile and runtime tested.

The first patch implements the partial DMI matching we discussed, hopefully
this method will prevent any further false negatives (thanks to Jean for
his input on the method chosen).

The second patch adds a partial DMI board string for the IN9 32X MAX,
enabling DMI board string matching. It depends on the first patch.

Both of these could go upstream; the first can definitely be considered a
bugfix, the second is more dubious, but since I've rebased it on the first
it could be applied later if required.

(One remaining question would be whether patch 1 should be CCed to -stable,
 since there has been a regression introduced into 2.6.27 and present in
 2.6.28 for some BIOS revisions of the IP35 Pro.)

--
Cheers,
Alistair.

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
