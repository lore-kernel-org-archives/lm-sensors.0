Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A726215E8B
	for <lm-sensors@vger.kernel.org>; Thu, 14 Aug 2025 13:20:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755177620; cv=none; b=kH2CwRxpTwnWOFilTBfTvbo5MO7FPnZt+SIgy+LQqb5wYpHi0XYVnsdHNo7AawcH45cT8i1bITPWojgCWxyMmiEVcxe6e7GOyrp2XcTpO8rijhKb4EE9v/ddYzqR746USd8BtPiUS6BhiQ/wXb3XqEzsFCIUQJX6DQd+zY049iA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755177620; c=relaxed/simple;
	bh=OZ+1U9tHOtUrK0uhtRjOueq26QQN2JJJDBE5CTbb2QA=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=kw6bIkFCfit5yVpmkcWwFh8gfgh4suUKKbPKOQmh8q8ehIjJZ3hZFpQeUY/dcmsCGjtcrjFMNXhg/aAxk2eeAAf33v5SH0Xhprt8mpgMm9R70eWDZEeKo3/xD1b7nEfTq3BLC1eP20h93wcFNMUaJv6kzePOlCtXoRFztp2Mm7c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=criticallink.com; spf=pass smtp.mailfrom=criticallink.com; dkim=pass (2048-bit key) header.d=criticallink.com header.i=@criticallink.com header.b=rBKaafnT; arc=none smtp.client-ip=209.85.160.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=criticallink.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=criticallink.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=criticallink.com header.i=@criticallink.com header.b="rBKaafnT"
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-4b1098f9ed9so6419401cf.0
        for <lm-sensors@vger.kernel.org>; Thu, 14 Aug 2025 06:20:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=criticallink.com; s=google; t=1755177617; x=1755782417; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=EMY9PsgEmTLvpKbs5eCrqeBfuJM80+ktLz9S2c7wlX0=;
        b=rBKaafnTFM7Uvgaegn/3LUyuo5KwsZz7G6j9eYFjMGLSagyV42N2iy+eJHUSD3RU0m
         dgkW4wPV2eISAN5KvE5E3iA8ESc+/90sFd4EUJX/vLMyGdIV8Xbs0rqBcMRBjbyvilm0
         W34CR381CfAHpMxpop/56J2kyMlIOL2Th4upI6o1q49bHLCDdxbITEBh13ZwfSo0HY9l
         fNN5nPKKtHMrdU1xJr6CJTR2TqKyLRBjTxH0RD50W2zlUj6SufkuqaoMDEYiD6M9kmAY
         S/52nfR7Anu5fLvKS35b7BwjEoq8caVER2Jv3XgjyUq8FTuzo1FI3SYAVSUB66Rupn4K
         2fFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755177617; x=1755782417;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=EMY9PsgEmTLvpKbs5eCrqeBfuJM80+ktLz9S2c7wlX0=;
        b=o8mNmZJjZG9IN/2mk4WD/SoBoGyw8YWv1vFRJmurCvoqOjqkSucboq8yV4QOfLe6j8
         HrcvgoXGHxT66odElZcjrTmv/+UMD7b62OUF8khjXjeeMXIB+whchKyoOCXwgCnwrrdP
         VViM7AqOixFFAE32HnsgaZyRFObCnq3JNDiTvF9Y+pYa5KglXuAiboTfikZCzl838OIa
         5mPurPa5uU9WlONWGxLW9w0+SDvrotihnJTC8ZPhypiThqTef4d9VlnYkqCJKpoIJAaJ
         9h1iPceAslEaUEapVl1pbukkMUj086i3DXDjQsrO+C+VA5xamL8RzN+2WD1epnfcwmVd
         hkgw==
X-Gm-Message-State: AOJu0YxlwYp46QiirpEWzb6uCPLT54Z5l6aK2eLJ134Xso0n5C9/AZRW
	LNom2qrgOwqVlzDo1TxLz6OgjZdTFwvjmEy3d9v2m8EZE2dGwkdTQRZ7s2oqBnOOMCbRJx2BAFt
	tU6lmrWbsLLSek640LgmYVo+F+sCxPhZq0AlIuVIYuHByqz3f2FYCmw==
X-Gm-Gg: ASbGncs6tMPnwJNrE9hbKieqGpYOI2NqLwCnJALcf3O4GHC2Ip9eMmDg7kkFzElvWvd
	0wuKn13xuMrwAIkCh++Wdrp0pA5aMnqUjfezfjF9YsdcHfWyffZrfIl6wAsXhcbw/ibiaepjtqh
	kc8GQwsyaRhPno3TGcAis8XzOwJgwiqXB+uchSEBNUOhpWdKCJLUaC7f11G0oCPEwpAF7gYrD7d
	EYTPw==
X-Google-Smtp-Source: AGHT+IFIxp+t9Td+gB+fDa5qgOqBYyZmFGGoumLuXewn5TAReBpyTtUqm9PIU/OcEUGcbkGjYYSmcaWlyqcoYFs66EU=
X-Received: by 2002:a05:622a:134f:b0:4a4:41d5:2a03 with SMTP id
 d75a77b69052e-4b10a914963mr45272721cf.4.1755177616980; Thu, 14 Aug 2025
 06:20:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: lm-sensors@vger.kernel.org
List-Id: <lm-sensors.vger.kernel.org>
List-Subscribe: <mailto:lm-sensors+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:lm-sensors+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Mike Williamson <michael.williamson@criticallink.com>
Date: Thu, 14 Aug 2025 09:20:06 -0400
X-Gm-Features: Ac12FXxxMWVrG3IJIivhxkG2_Ttqq1Cj_U26tjk7oSy0QaBI2YDSapdCw2m25KM
Message-ID: <CAHEoWwsxq7Tk-GSCLA3xne_b6qrKUqh1u4aXdp5-1oZe=L05xA@mail.gmail.com>
Subject: Trouble with sensor chip label matching.
To: lm-sensors@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hello,

We are trying to set up a configuration file for an ads7828 chip, and
are having some troubles.  We have two chips named ads7828-i2c-11-48
and ads7828-i2c-11-49.  If we use the fully qualified names in the
chip command of the sensor configuration file, we don't get a match.
I have tried the following:

"ads7828-*" - matches both devices
"ads7828-i2c-11-*" - matches nothing
"ads7828-i2c-11-49" - matches nothing
"*-i2c-11-49" - matches nothing
"*-i2c-11-*" - matches nothing

I feel like this has to be my error, but I am stuck.  This is a yocto
build lm-sensors suite at version 3.6.0.  Are there build options for
reg exprs that have to be enabled?

Thanks,
Mike


 --
root@qcs6490-mitysom-devkit:/etc/sensors.d# sensors -v
sensors version 3.6.0 with libsensors version 3.6.0

root@qcs6490-mitysom-devkit:/etc/sensors.d# cat sensors.conf
bus "i2c-11" "Geni-I2C"

chip "ads7828-i2c-11-49"
        label in0 "1V8-MEM"

root@qcs6490-mitysom-devkit:/etc/sensors.d# sensors ads7828-i2c-11-49
ads7828-i2c-11-49
Adapter: Geni-I2C
in0:           1.81 V
[snip]

-- change sensors to wildcard, but this won't work because we have two devices

root@qcs6490-mitysom-devkit:/etc/sensors.d# cat sensors.conf
bus "i2c-11" "Geni-I2C"

chip "ads7828-*"
        label in0 "1V8-MEM"
root@qcs6490-mitysom-devkit:/etc/sensors.d#

root@qcs6490-mitysom-devkit:/etc/sensors.d# sensors ads7828-i2c-11-48
ads7828-i2c-11-48
Adapter: Geni-I2C
1V8-MEM:       1.81 V
[snip]
