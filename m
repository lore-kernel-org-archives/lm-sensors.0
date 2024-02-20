Received: from sonic317-27.consmr.mail.bf2.yahoo.com (sonic317-27.consmr.mail.bf2.yahoo.com [74.6.129.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 547CF612D7
	for <lm-sensors@vger.kernel.org>; Tue, 20 Feb 2024 21:13:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.6.129.82
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708463597; cv=none; b=XgO7lRHo6eNwZWpkzCpKbar/wgHrmlSDzeyDlo41NQrRWMmdieNCWQVpwKM/8QO9SOpAOqQjJHDp/Zi3gb8tl9J2OT/vlJ/VZDT5KJ3r7hVlxlyxxTN8TFX/cmvK5Cd5PEVkDkeHZUxBzGhKIpEMhdWJ3/+25gAl4o/WfUKM4RM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708463597; c=relaxed/simple;
	bh=1vyvrVoT/ZdUsVhZaA/40lfeSmhzgg/w9Q2PN9vjuPQ=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Content-Type:
	 References; b=CFV363OUeIkSppqjo79isY5jcDKzv0tGg+a3aCA1fgSFZz01bd4g5LUmQ38O5YSJBCaI7+MuF20APbHr80uRSo4BBu9rbTlyqGAomNbcj+WdHix6LFEVXrf5C/y1sp9QRoWQpo4P+o3smpR1WxWa/ImIqhnA3OLlEM9GaC44ANc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=rocketmail.com; spf=pass smtp.mailfrom=rocketmail.com; dkim=pass (2048-bit key) header.d=rocketmail.com header.i=@rocketmail.com header.b=WApp9m11; arc=none smtp.client-ip=74.6.129.82
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=rocketmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rocketmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rocketmail.com header.i=@rocketmail.com header.b="WApp9m11"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=rocketmail.com; s=s2048; t=1708463594; bh=wKb6rwDVuvH+egt6gcl4WYzj0P//3rbH+hcwIdtLzRU=; h=Date:From:Subject:To:References:From:Subject:Reply-To; b=WApp9m11c1NXUrQTfsLd2U4hT+t/erUU6vXLBzesfAuG2ipaBdgQzPZiU6Bz4gBxuWTZDQ6xW+URSs/oAT6+bq1ILw6l8cZcPO7bFUe/DQ0hSp2OzwCXhq+J/3jS9hnva2bYoxWE6v0J1MEI8aNPxGUjjJBkk6eqO2BJdl3+nzwA1S3VCAZsBeoBPYnY3CJ+W0Zr7ytxaq7JdjoThl8sGSUzsDtx0gUWLyyAwGF8uvT/3dU63jmzlo93tq8TjXS3YztWQDPvQcxVTIXKbQ2JOvP7K/DhZaCBZvFwEgClhWcxqqUi2nMeB4XRIei5s+SLEJO+gMeI+zv/QKPqfteKOw==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1708463594; bh=GwFdLMDT0fkKFPLlFrpyBtqGFy+1eRbk0yVXlWWCtvX=; h=X-Sonic-MF:Date:From:Subject:To:From:Subject; b=SdjEV2LRX+QnH6MvIwgrfd4KeawAwRvQOFfW2k5iXzbP3gNXAgN3DZpRel1QTTxxang5HV/G7xilaTZhv+UQhbzDyPQbsfrGmVsFLl9IHcO2Q9ykOnRijlb0Z22HhRRxMKcWtnLgzlKoqg9LrASbAlLCiIBIEJC2IK0ioqLx6XcmDYtSKMkNKh6E2M86l5xQp7cXFvElET4LuNgkgki2GR3L/rtCvewqkgrrqBwsBql+xEL8daJST8cITEDCxUiFJPJDjXQhSh1lBAffsyu9dVhPkwdGbP7CDmbm4efGne4DuD72KOwLQm/lRXbX2jyykP1UjSewGKY4srTGNQx/Fw==
X-YMail-OSG: oD7RAYIVM1mvHLxG4lmxce1HIlCH5T5N152DkvjfFZ86qvwT66HeIG6tGHR1f.V
 U7YQ00jGkPD0xKol7nwj_OofagcTUEMFOOll2X1yBydAwKGpadPF0GfGaUjAizE3WiOAOxZ83aBg
 s1h_vCwesDvaypzHp79wty.v8O3wKhMupFZ8OtP.cFvMXPtmODm2ouLdi7NWMtbjTGnow6X51Rxf
 cEfNq4M37uqGSZvlK5EMRTXEHnvqnpzvXpxb.yAuLEMLgov.NnIDRS8t.wk8WsM3J5hTe_rDUGHc
 ClLjzZuNi.f9UP0VjexyF1WIHQkK_Esd7bT2JTffhS2UmBTrlNfdSj9MuOIEtzPwdXtB_Quql_XP
 bH7YpcIZATor.2PPXoPhvNJWD1NccNGKJGdgTSetEF4ihQsc5F2Xx.P7.XKzVwqnfzxRILbdJPkJ
 SZA43Yv2qPn1VbydphPXtejEnKnIE4Vr36qIiFN8iQtstbc_86St2yGAqjf6Q8IeMXvGXxKNu7PB
 hre8lmDxfTM5LikXCUAhiBuqWUxvgByQAfuG42PGoB7y9fUTxdjOEQQwIXeD1fVVeRL2CdoHYyZ4
 wHAk2LCiPNTDNm24HJaecWjS6G8Fn1wlk46MAxFielfFoji0WvJNYTYLZfssFukmvtqNfVYgcA9H
 6Jg6mzH7CcI2D6R.nxrf3oUmNyOq2ezJt40RxXgjA6gEUvp8ibeGEa2BsEDI9Y5JzklibFozRQtd
 R39ifzaHsHhyZMLfmLMmNQX45jC6sFP7ThKW309ya1F5R.rUXOiIbykVGEtHkVd.cmDxAYBycWbd
 zc2luPXo7MSh9_xlY3yu2eKm7gm5WViaKUvfOYa5rrExU4kx62q1wSpqvAV51bEjgyonEyBunvqy
 QY12WiwPrOGpBFfLiEXtlgK9C55wdf_bgFaZrZ698KG0T4i.fXxv.BM6GqfBMSZdgupUHJE80uvp
 QkXeqfzgF22dnQ2wqyUgVwKUGhr_6YEAn3hnSmbzUciRiHCOjggMk4ZREYQ_OPCEysj5OIOqTgmp
 fs27DXgoknwDvsNxheYUdLcA8oelGp7J6UihuH8w9iWK9xE7JD5hQ8fPkNOQVN3gFwOOsBMu1NAN
 9UYBubCA2YmPpHUBLtznvzYidET3mXd0J5sf.xVCs80I2nhLLscHmsexjInXLZMDUYRq4P.d1.5e
 lEoGqhmHKkvfSlHhTdpB5Qo8RDKEh_AbTu3sYv.ghwhH3Q9dleLMdS0bg.f7V.5zsmNKbzQCJ_MW
 YJZQG3IoX7u2w_Ivl7kVR0OmxmqBlyugZK.ZhS1xI2lz76d_V7sztvII2q2EHU3fH4H7YRxqfibc
 rzZ2apYGdjjTbdJl2wbqnC9fw.Me7Dg_4Uy1u0iV1HyLbUwfzORGYgSQ0D8dEfwILPYJJtat0JXw
 fnWTpUdgVu5a5Hzc8pRNnAQBFyWB5FQsDczC9sRG0VtvmsXbKvlHdtWBedL.4ogbUU5rxzbGJEgZ
 B77827AiJp2C5FSFrHilm18oF62Rt4xnWz08m2us6JgStwBx8RcQyoUSlonjGpclmG372rmjip6q
 tQnlpPlrFqvURpAhB4ru6Dx45mdyf5eEkd6FQkFFOZfrjzJrZkzkTuqXGc7zI9b83.JeFLgoB2dN
 QKH7Fglp7DL7supWaJD_z0o_99yC.WX71NsVa7zS0IKCNM7dY0hXICroBrlDEU3zomidxMhacGt0
 O2I6Cj5f9Ti15D7C8W3VaJpB6I38cLzMKHtUNdkVWUk0hRM3sIM2QZa.oI6xbb.D2oxc4oEN57jY
 MDGiUf2bvoPvmSk0rG4KH9_.Gz9eepQFaCb0AfXU8yQqfWCS92V6dWJG.ZPI7MBJetZh6d4ikoC5
 x1Zb6MhFJr3I3nEMuKaW._tgmdhl53zdzFjm3UXo5vevylXtay2xhWRBGAClBzd5hvABlV55G7rF
 OsmxbZqSNHinstPDi11of7FuBlBPERZwJjkq2ZxGtSmZApcJ7z1y4CXx69V3igW5g0wfLzqeTNu9
 coPV7cDSKaQT2JhMEVkfStHQBF.z_EVWXdBB5PmhaLAOxksIS3H3wm21iUeIlc.noLx2RNFRz3mF
 Q6sfplKToARWZMU9Ilu2wE0APz8nFsFRFa1aenaDxrAl8azKPQCa.NSqKm61TSE0AnHanqIAqbKj
 WFjRYLv6w8ngXZeZmrbE.LC_aNFf6H4V2WupUBVkmOJKIT6m1NCZ68c1Vzbk8UFKIbfMgfLMZHqo
 eQcenn_GU7eIViMBAowhd9KzGu50O7DgoFpb1M9TMqC8DaifMU04Xd17JeDifySOY3f6b
X-Sonic-MF: <sukolyn@rocketmail.com>
X-Sonic-ID: 932998fa-ee43-4a6c-b0ba-b5d25659b287
Received: from sonic.gate.mail.ne1.yahoo.com by sonic317.consmr.mail.bf2.yahoo.com with HTTP; Tue, 20 Feb 2024 21:13:14 +0000
Received: by hermes--production-ir2-7bc88bfc75-ll9h2 (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID abfaaea9811631a53a29fc714d15bb90;
          Tue, 20 Feb 2024 21:13:08 +0000 (UTC)
Message-ID: <c8b4f811-c320-4dfb-8e39-bb21b68932e1@rocketmail.com>
Date: Tue, 20 Feb 2024 22:13:07 +0100
Precedence: bulk
X-Mailing-List: lm-sensors@vger.kernel.org
List-Id: <lm-sensors.vger.kernel.org>
List-Subscribe: <mailto:lm-sensors+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:lm-sensors+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: sukolyn <sukolyn@rocketmail.com>
Subject: numbered labels make JSON parsing difficult
To: lm-sensors@vger.kernel.org
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
References: <c8b4f811-c320-4dfb-8e39-bb21b68932e1.ref@rocketmail.com>
X-Mailer: WebService/1.1.22077 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo

hi,

here's what outputs lm_sensors when  I ask it to print JSON :
```
$ sensors -j | jq -r '.'
{
   "radeon-pci-0100": {
     "Adapter": "PCI adapter",
     "temp1": {
       "temp1_input": 34.000,
       "temp1_crit": 120.000,
       "temp1_crit_hyst": 90.000
     }
   },
   "coretemp-isa-0000": {
     "Adapter": "ISA adapter",
     "Package id 0": {
       "temp1_input": 32.000,
       "temp1_max": 80.000,
       "temp1_crit": 99.000,
       "temp1_crit_alarm": 0.000
     },
     "Core 0": {
       "temp2_input": 32.000,
       "temp2_max": 80.000,
       "temp2_crit": 99.000,
       "temp2_crit_alarm": 0.000
     },
     "Core 1": {
       "temp3_input": 25.000,
       "temp3_max": 80.000,
       "temp3_crit": 99.000,
       "temp3_crit_alarm": 0.000
     },
     "Core 2": {
       "temp4_input": 28.000,
       "temp4_max": 80.000,
       "temp4_crit": 99.000,
       "temp4_crit_alarm": 0.000
     },
     "Core 3": {
       "temp5_input": 26.000,
       "temp5_max": 80.000,
       "temp5_crit": 99.000,
       "temp5_crit_alarm": 0.000
     }
   }
}
```

as you can see "temps" are numbered.
imho, it's wrong JSON as it is "the same" data for different objects, 
and it makes it difficult* to parse to get temperature.

I noticed that the same labels are used with -u option, but it doesn't 
seem more reasonable.

--
* I've found solutions, but it's not as straight as JSON should be with 
not numbered labels.

