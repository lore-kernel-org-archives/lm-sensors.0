Received: from stargate.mehconsulting.com (stargate.mehconsulting.com [65.78.188.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3BA21DFC6
	for <lm-sensors@vger.kernel.org>; Sun,  3 Mar 2024 18:30:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.78.188.61
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709490656; cv=none; b=TzAGosodSf0R6tv9sByGkv0IxRDJ5M/rh7kWOKUq4C4evrD12WB7yBl3w5L1HwH366MjPNXzL457PWPlCHYLjdwbQIHjfeJebM1XJt31+GxwxbzogjS3cA5uSEtWcIIlgDWzxDQG3SHIf02Q+xH3eyTw9QMmaHOA6Jt+0Hgq0XM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709490656; c=relaxed/simple;
	bh=KcRUY0AORixaP2GKi8RC3Y7FER6B8F7lDcf1Qw++6bM=;
	h=Message-ID:Date:MIME-Version:To:From:Subject:Content-Type; b=RzYUqBH51HHs/+PNxqy6Zz1PH4qAWPiZAfhsD+0PEWhO501L3JyXQPgShcHBVV9gQ/7w3MYx1p+2euY1P5xXZKiVBygy7dPmL5Jfg0objYNMfgp2FHLreuCiHCEBfsB6cP5JE62brh4tsOW3wzH/l6rEECVeg6ZwdDNbYyDPDdE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mehconsulting.com; spf=pass smtp.mailfrom=mehconsulting.com; dkim=fail (0-bit key) header.d=mehconsulting.com header.i=@mehconsulting.com header.b=OtxRa/ET reason="key not found in DNS"; arc=none smtp.client-ip=65.78.188.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mehconsulting.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mehconsulting.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=mehconsulting.com header.i=@mehconsulting.com header.b="OtxRa/ET"
Received: from [10.1.1.66] (Atlantis.mehconsulting.com [10.1.1.66])
	(authenticated bits=0)
	by stargate.mehconsulting.com (8.14.7/8.14.7) with ESMTP id 423IUq9a013411
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NO);
	Sun, 3 Mar 2024 10:30:52 -0800
DKIM-Filter: OpenDKIM Filter v2.11.0 stargate.mehconsulting.com 423IUq9a013411
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mehconsulting.com;
	s=default; t=1709490652;
	bh=KcRUY0AORixaP2GKi8RC3Y7FER6B8F7lDcf1Qw++6bM=;
	h=Date:To:From:Subject:From;
	b=OtxRa/ETW1klgugujbQkbmPzPgTX86AQkVw3zB6NLusKEBGdiFErP1RBbWgTSdfqs
	 Z73O7++osvEt0gAicBTW1KjbHbYpTRjrsixpCCqvTupAAtAMmLixLsi9jtKSoYtULq
	 rNVGVxxOXl+x2AIR7oFes/HraJr0csCGA/p0rlSQ=
Message-ID: <6e219d26-245f-48cd-a945-252c98c5d5a5@mehconsulting.com>
Date: Sun, 3 Mar 2024 10:30:53 -0800
Precedence: bulk
X-Mailing-List: lm-sensors@vger.kernel.org
List-Id: <lm-sensors.vger.kernel.org>
List-Subscribe: <mailto:lm-sensors+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:lm-sensors+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: lm-sensors@vger.kernel.org
From: Mark Hansen <mark@mehconsulting.com>
Subject: Trying to find a way to support lm-sensors on my AlmaLinux 9.3 PC
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

I've built a new computer to replace an existing bastion box (providing firewall, routing
and various other services) for my network.

I've selected a Gigabyte Z490 Ultra Durable motherboard, but am having problems getting
lm_sensors running. I've been researching for a couple days now and it seems Gigabyte
does not share the information necessary to create the lm_sensor drivers for the chips
on their boards.

I don't relish the idea, but I'm willing to abandon the Gigabyte motherboard and select
another one, but I'm having a hard time finding a new board I can select that will support
lm_sensors.

I'm looking for a board which support Intel i9-10900 processor (LGA 1200 socket), DDR4
2666 MHz DIMM memory and NVMe M.2 SSD drives.

I've been looking through the example configurations on the lm_sensors github site,
but I can't seem to find a configuration which matches any available motherboards.

First, is it possible to get the lm_sensors to work on the existing Gigabyte Z490 UD
motherboard? That would be my first choice.

If not, any help in choosing a suitable replacement motherboard would be very much
appreciated.
