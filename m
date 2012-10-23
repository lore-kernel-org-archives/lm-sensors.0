From: Jean Delvare <khali@linux-fr.org>
Date: Tue, 23 Oct 2012 16:32:51 +0000
Subject: Re: [lm-sensors] w83627ehf: Wrong values reported after resuming from suspend/hibernation
Message-Id: <20121023183251.228083ff@endymion.delvare>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="MP_/Kj2mQRnTMgxP5NyDEr.mBfa"
List-Id: <lm-sensors.vger.kernel.org>
References: <50856051.5070803@gmx.at>
In-Reply-To: <50856051.5070803@gmx.at>
To: lm-sensors@vger.kernel.org

--MP_/Kj2mQRnTMgxP5NyDEr.mBfa
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi Harald,

On Tue, 23 Oct 2012 11:57:41 +0200, Harald Judt wrote:
> All values except the ones mentioned are being reported correctly after 
> resuming.

I have attached a shell script which will dump all registers from the
chip. I would like you to run it before and after suspend, and send me
the results. That way I can ensure that I save and restore all relevant
registers.

# rmmod w83627ehf
# ./isadump_all_banks.sh 0x295 0x296 before-suspend
(suspend, resume)
# ./isadump_all_banks.sh 0x295 0x296 after-resume

This will generate 8 dump files, please send them back to me.

Thanks,
-- 
Jean Delvare

--MP_/Kj2mQRnTMgxP5NyDEr.mBfa
Content-Type: application/x-shellscript
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename=isadump_all_banks.sh

IyEvYmluL3NoCgppZiBbICQjIC1sdCAzIF0KdGhlbgoJZWNobyAiVXNhZ2U6ICQwIEFERFJSRUcg
REFUQVJFRyBwcmVmaXgiCglleGl0IDEKZmkKCmlzYWR1bXAgLXkgJDEgJDIgMCA+ICIkezN9X2Jh
bmtfMC5kdW1wIgppc2FkdW1wIC15ICQxICQyIDEgPiAiJHszfV9iYW5rXzEuZHVtcCIKaXNhZHVt
cCAteSAkMSAkMiAyID4gIiR7M31fYmFua18yLmR1bXAiCmlzYWR1bXAgLXkgJDEgJDIgNSA+ICIk
ezN9X2JhbmtfNS5kdW1wIgoK

--MP_/Kj2mQRnTMgxP5NyDEr.mBfa
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--MP_/Kj2mQRnTMgxP5NyDEr.mBfa--
