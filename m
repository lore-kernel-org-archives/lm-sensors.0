Received: from se2q-iad1.servconfig.com (se2q-iad1.servconfig.com [199.250.216.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9100D38DC8
	for <lm-sensors@vger.kernel.org>; Sun,  3 Mar 2024 18:28:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.250.216.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709490533; cv=none; b=HSdDaXDy695cwmL9P6/yVkUWy0BCK1Il1e72EmUgIvOu3quq2fApYOOsEkDC+nWhLCcrTyWFXCb87hCtt5K+IzwllYhr+8Hkc3i/IGHecUfLE9KdVn8Os4phW9gM0qIA/X4MxQ6UCeviPUB8jbA2T8XNNwS48i86vW/qx+LfFgY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709490533; c=relaxed/simple;
	bh=Snz7vYUCtFyjwaJjNxYUGwNKiJVM9qe8EUJVY0s68bc=;
	h=Message-ID:Date:MIME-Version:To:From:Subject:Content-Type; b=YChYfZ2R+pS4rHvwiKRabdap/5x7PTElOMfFPXUht8fRCVhlFJI+V1XSatztomaHVArif399t4dI06owhIt80AgV8rt706WxPu0M/l1uIMKfIMoMGHL+mSMRkhT1Uy47npvEoCDJH4kLF7MtyV0Hh3x9KEQZ4/NW/43T/g6Mf3I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=luddites.org; spf=pass smtp.mailfrom=luddites.org; dkim=pass (2048-bit key) header.d=luddites.org header.i=@luddites.org header.b=o76z3LX/; arc=none smtp.client-ip=199.250.216.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=luddites.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=luddites.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=luddites.org header.i=@luddites.org header.b="o76z3LX/"
Received: from whub65.webhostinghub.com ([209.182.197.148])
	by se2-iad1.servconfig.com with esmtps (TLSv1.2:AES128-GCM-SHA256:128)
	(Exim 4.92)
	(envelope-from <bill@luddites.org>)
	id 1rgp7E-000BFu-1c
	for lm-sensors@vger.kernel.org; Sun, 03 Mar 2024 11:55:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=luddites.org; s=default; h=Content-Transfer-Encoding:Content-Type:Subject:
	From:To:MIME-Version:Date:Message-ID:Sender:Reply-To:Cc:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=1Vg/qqEr7SMyuFCsuRSk4ZYfc1ROlCnzTyUVqB4RFEM=; b=o76z3LX/s/1MM8ZbWWr0uzkAz1
	+hCpoO90V9oOdjrrJd8d5zljJIFcZb4lTsH0KgS+mLo2E5RWbubkSFfioY3Hgt8IxKcGbVDW2xJKh
	FFcvgWp69JOUxDUM63loEkCGPiDgQPTpZKcD5NRb2fUkJjbOXuUNJ6X/u0p2y5BYt0lq1diFxBaGv
	R/6T7Eoq9sumS3PnXC0x6hxXZEbGusdNl5hSCCuNOTdy3pjdBH8DJN91y0NEl1Y9vYq1sun2CovpR
	AvGONFvchFlKbdPQC4Bbmr+op+fqBx9kscDXJFOrcAUMF6w47Ed/Wimnc/C1GVDpDYCM6APE9ifpS
	TeCKnZBw==;
Received: from [24.121.78.41] (port=49320 helo=[192.168.1.242])
	by whub65.webhostinghub.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.96.2)
	(envelope-from <bill@luddites.org>)
	id 1rgp7D-00CJkM-0j
	for lm-sensors@vger.kernel.org;
	Sun, 03 Mar 2024 08:55:07 -0800
Message-ID: <433c02cb-f8ca-4965-900b-93e57e4f868b@luddites.org>
Date: Sun, 3 Mar 2024 09:55:06 -0700
Precedence: bulk
X-Mailing-List: lm-sensors@vger.kernel.org
List-Id: <lm-sensors.vger.kernel.org>
List-Subscribe: <mailto:lm-sensors+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:lm-sensors+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: lm-sensors@vger.kernel.org
Content-Language: en-US
From: Bill Swisher <bill@luddites.org>
Subject: Processor temperature.
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Get-Message-Sender-Via: whub65.webhostinghub.com: authenticated_id: pita@luddites.org
X-Authenticated-Sender: whub65.webhostinghub.com: pita@luddites.org
X-SpamExperts-Domain: whub65.webhostinghub.com
X-SpamExperts-Username: 209.182.197.148
Authentication-Results: servconfig.com; auth=pass smtp.auth=209.182.197.148@whub65.webhostinghub.com
X-SpamExperts-Outgoing-Class: ham
X-SpamExperts-Outgoing-Evidence: Combined (0.11)
X-Recommended-Action: accept
X-Filter-ID: Pt3MvcO5N4iKaDQ5O6lkdGlMVN6RH8bjRMzItlySaT9q5xV0ybRQpT0WcYjN5GbwPUtbdvnXkggZ
 3YnVId/Y5jcf0yeVQAvfjHznO7+bT5wpyHchVPeXBDTEHlRMzgbOt8C9mOBdONdnsxgsk1D2pw/C
 h5SE4jAyhe1COeASyU8+44JdA2tdtX00de+0jZY64ld5rdi2ZxohSIq+dqifZr6JHbHV3hVAgdrm
 zieH66/E5vTP2QH94Md3XnD/LntPm2Mbb9SmE7CrndaGFHnrn6uxYeKHW6LxoeeUc4aDWmEqOS8O
 J7ycceStJz72PftL4d51VN6FLGUm5LeF0L0j7wEbMp8Qx9A/kiwyVnREl84sOdAaBGAeOKhTx+m3
 vF4LsArQv+5M23dYLDjUbMZvVmr6m72Gjb0JXKncO30D1zlDSsJwEdqFYrGPm5xKlgiouZJZitb2
 t8CUnIPdqYP/43TaVz/7pRFegyFAy3NGHeok5WBPmXJ/Kdaz6RuuD9cuG5/1GojKNk/vA6TUbp47
 u2sI1JuLkyxl+s9t81KNtzMGoIWEg0dLSnZQ5gvjZLDcjS7UkVihpqIaIpf9QIiqPrZIF8ronaI7
 xIN6o34ogH/74O4hBSz/kkmPgL+fgIguTDwBv82NOyZNp9oAZxK++5os4AwmVea3c7k3uTTxh2KN
 2YK2efe0QvVg98Bm6gDGE9tJ3vM773gOGIZYRN78xxSPYp7ADOYj/umowLvI1inRtFuayQSHKxuV
 s+RmqoRqqe0qvr5yub6t9+RpDpmA6IxofubIxIUuJD4XGA53qx4bWomJ+lMxSlyX1N5GXeu6SPru
 VoRKfuxC83Ks1XGpENVxMih9OtXJ7FZz9/pfEfIccBIk1Sag4dKiqCrF8eZZ1SBDD9TIMpb/6LBv
 5l7q/Ybw3GZ70EJqGgXE6L2bFmScPoi9dStZ4seQEAQwaScNzn0AJqSgN05l6/hQNxUv3sMxMv6P
 CzQDaHObbgFJu+m2Km4sAJ1Q+VAXXWPIu0H96ERCN/TYO8Po1sFYLrYxp7Wpcv7j2jxrOCLgGCCA
 557WA+a3YgjzHsSBZ2l8bHDKG1qJifpTMUpcl9TeRl3runBqz7TRiWF91U/smddrJvE=
X-Report-Abuse-To: spam@se1-lax1.servconfig.com

I have a mixture of mostly AMD and a few Intel based computers. I run boinc on 
them which runs at 100% utilization. The sensors package gives me an indication 
of the temperatures, but I'm not sure I'm using the right sensor to measure with 
and what that temperature should be.
So, I'm asking is there a place where I can go find the proper sensor to work 
with, given the processor make/model and MB make/model, along with the maximum 
values for temperature?

For example, on this computer:
openSUSE Leap 15.5, all the computers have this in common
AMD Ryzen 7 5700G with Radeon Graphics
ASRock B550M-ITX/ac
CPUTIN: +74.0°C  (high = +80.0°C, hyst = +75.0°C)  sensor = thermistor
The sensors command show multiple temperatures and I guessed this was the one to 
track.

Any assistance would be appreciated.
