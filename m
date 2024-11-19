Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41E1B1CC174
	for <lm-sensors@vger.kernel.org>; Tue, 19 Nov 2024 14:53:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732028014; cv=none; b=I7bx1sLREL0tNFoTvscpemZJY6DXZ6CG+hPntG9TUjQpVYHeiTYdCsOc+b0FhLQWXbjktAlVxnV35CSRuRxzRlP0xSetpHPiNNqt9aEeg4HuZFEUrT9WtIbH8s3q9VZ2tI8n0NwDqMUYw/HA2iNLRQc6oRw04vfL3z9DDN3galA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732028014; c=relaxed/simple;
	bh=nEM4deVAmAbumjCiia6GBGXNl6qn9eHjuwYBjmXU3Vw=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=joKleK6j5k//BwQYmgWNO6IxE1DrC0wgbOXkACBzA7eH3YF13754oaN5MOqc/lDWeaqME0cuvP3UT/SejXl/ANZ2KhR7bORQwGTLWca1Rn6MGeEQr+gr3BXUGERjkDaJ2AB3jSvxezYfIOqesjkvrmC9te2Zs6Iu6eJUgRif9tM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bJQ4HSql; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bJQ4HSql"
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-7246c8c9b1cso2426249b3a.3
        for <lm-sensors@vger.kernel.org>; Tue, 19 Nov 2024 06:53:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732028012; x=1732632812; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=nEM4deVAmAbumjCiia6GBGXNl6qn9eHjuwYBjmXU3Vw=;
        b=bJQ4HSqlZhVG/DpEk36LZ/xucgHGWcVvXnp1zHKduyuOU+iwNIUUHFFfxKFhBpRucX
         sU0+s72DuSUkuscu9O6y0YIeigDJ71xyEZ08vU60zVEa02qEV6Dga8kC1r/7K4FzgYPE
         aoKG2jJrH91l8HXonptP6R3Rh3Xcuh55mS2L+cSW+AcYmOQK3oG4ctzAioLxHEooC3nZ
         0h7wSbrWcHBSWkCQDXEMp3WoBjuKBzOgnC2a5JuOkTS1T4561nXYxdYxGkwG1yEcCJH5
         DBttmSjFg3qhCnEom4PEklje+0SDbEQ8u3DsLJ681tmr43Y18hGDLRNLgUi8tkLcv5pn
         umpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732028012; x=1732632812;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nEM4deVAmAbumjCiia6GBGXNl6qn9eHjuwYBjmXU3Vw=;
        b=doXUE0eKeBzH5eGL41FA+NhOl/m8eNQ+a5bp/NcH20LvmqUgF57BhobUaleWPkXo3S
         bQ9DfzOs9MQAt+T6KaG4itaISmTDGxNE+PIRmjTd+EzX/FH1thLNlnsdpK2DPgTi6LBH
         xrsuTMUAgj1tpGcSyZohOC0nY0z1FfPVn38b6jCK8+xZr9VqaHHv9aDvLjbebZWDPgEp
         2jOeSl13S1V2lMe/FsnFNT22PA/ljYCSBF1Q+BKZeE/LVIMHSMVVR+7rXqUlMQz/GAVH
         En225O/j3ZwjNFFdIBAa1riblNs0OcyfBs6UyLikIyQdajcaRcU56QObtwLmtcGCqD4D
         RxNA==
X-Gm-Message-State: AOJu0YwREzVQD6r44kNX18oE1cd1HYXtwfUWtGqYFcWWAGLj3fzXAPAr
	MD0pm+sfj3Fm3V/f1U0fY2iit+KeryCAj5pUyEK2jatowxw/zttH+n3R/jhXbMw310C919BkD3e
	D//UIvcVFDbuvefts1KRMd4z5c6GQN+Ey
X-Google-Smtp-Source: AGHT+IGZWtxE81K3JsZP8urlZPXBzRHknScd7d/MpTb66cCkrXmjvcVUaW3G71MnFpyO7v/gpTwP2gn9q114PWUu2ks=
X-Received: by 2002:a17:90b:4d91:b0:2ea:696d:732f with SMTP id
 98e67ed59e1d1-2ea696d7410mr9907533a91.29.1732028012529; Tue, 19 Nov 2024
 06:53:32 -0800 (PST)
Precedence: bulk
X-Mailing-List: lm-sensors@vger.kernel.org
List-Id: <lm-sensors.vger.kernel.org>
List-Subscribe: <mailto:lm-sensors+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:lm-sensors+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: =?UTF-8?B?UmFmYcWCIEh5xIdrbw==?= <rafal.hycko@gmail.com>
Date: Tue, 19 Nov 2024 15:53:38 +0100
Message-ID: <CAJBXuqRSB3ighBcBHXTYqxf30Uz-nDi_Cjwqdk4LqNqMqDZwHA@mail.gmail.com>
Subject: Inquiry about lm_sensors compatibility with ThinkPad P16 Gen 2
To: lm-sensors@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello,

I=E2=80=99m wondering if there are still any known issues with lm_sensors o=
n
ThinkPads. I=E2=80=99ve come across some discussions mentioning that
lm_sensors has caused hardware damage in the past. However, I couldn't
find information on whether the new ThinkPad P16 Gen 2 is fully
supported.

I would greatly appreciate any insights you could provide or if you
could point me in the right direction for further information.

Thank you in advance!

Best regards,
Rafal
