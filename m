From: r.marek@assembler.cz (Rudolf Marek)
Date: Sun, 11 Mar 2007 21:57:24 +0000
Subject: [lm-sensors] get rid of i2c-isa - h now - fixes of w82627ehf
Message-Id: <45F47B44.8010108@assembler.cz>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi all,

Thanks for the review. I fixed the issues. Moreover I did:

0) fixed the Kconfig - deps fixed plus now it mentions the DHG.
1) forgot the name attribute - so it is fixed now
2) removed unsigned short address * (I put that into sio_data)
3) removed global REG and VAL for sio access
4) chip w83627ehg report its name in "name" attribute as w83627ehf
   to preserve compatibility of libsensors
4) changed the resource handling, platform device allocates the full 8byte
region, and report itself there with sio name. So in my case:

0290-0297 : W83627EHG
  0295-0296 : w83627ehf

The datasheet mentions that the chip decodes just +5 and +6 but it also mentions
that last three bits belong to the chip. I must check if it will hoose acpi pnp
or not.

David, this patch works for me, care to test it on DHG too? (Again be careful,
this is very hot patch ;) Maybe you can read and check the DHG specific changes.

Thanks,

Rudolf

-------------- next part --------------
A non-text attachment was scrubbed...
Name: w83627ehf-convert-to-platform-driver.patch
Type: text/x-diff
Size: 38392 bytes
Desc: not available
Url : http://lists.lm-sensors.org/pipermail/lm-sensors/attachments/20070311/f8cca0b2/attachment-0001.bin 
