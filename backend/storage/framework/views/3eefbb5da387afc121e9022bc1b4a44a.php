

<?php $__env->startSection('title', 'Skill Exchange - NOERA'); ?>

<?php $__env->startSection('content'); ?>
<div class="page-header">
    <div style="display: flex; gap: 8px; margin-bottom: 24px; border-bottom: 1px solid var(--border-default);">
    <a href="<?php echo e(url('/skill-exchange')); ?>" 
       style="padding: 10px 16px; text-decoration: none; font-size: 14px; font-weight: 600; 
              color: <?php echo e(($tab ?? 'search') === 'search' ? 'var(--primary)' : 'var(--gray-600)'); ?>; 
              border-bottom: 2px solid <?php echo e(($tab ?? 'search') === 'search' ? 'var(--primary)' : 'transparent'); ?>;">
        Cari Partner
    </a>
    <a href="<?php echo e(url('/skill-exchange?tab=my-partners')); ?>" 
       style="padding: 10px 16px; text-decoration: none; font-size: 14px; font-weight: 600; 
              color: <?php echo e(($tab ?? 'search') === 'my-partners' ? 'var(--primary)' : 'var(--gray-600)'); ?>; 
              border-bottom: 2px solid <?php echo e(($tab ?? 'search') === 'my-partners' ? 'var(--primary)' : 'transparent'); ?>;">
        Partner Saya
    </a>
</div>
    <div class="page-header-content">
        <h1>Skill Exchange</h1>
        <p>Temukan mahasiswa lain untuk saling bertukar skill. Cari partner yang bisa mengajarkan skill yang ingin kamu pelajari.</p>
    </div>
</div>
<?php if(($tab ?? 'search') !== 'my-partners'): ?>
<form method="GET" action="<?php echo e(url('/skill-exchange')); ?>" class="search-bar-page">
    <input type="text" name="search" placeholder="Cari nama mahasiswa atau skill..." value="<?php echo e(request('search')); ?>">
    <button type="submit" class="btn btn-primary">Cari</button>
</form>

<div class="section-card">
    <div class="section-header">
        <div class="section-title">Partner yang Cocok Untukmu</div>
    </div>

    <div class="partner-grid">
        <?php $__empty_1 = true; $__currentLoopData = $partners; $__env->addLoop($__currentLoopData); foreach($__currentLoopData as $partner): $__env->incrementLoopIndices(); $loop = $__env->getLastLoop(); $__empty_1 = false; ?>
            <div class="partner-card">
                <div class="partner-header">
                    <div class="partner-avatar">
                        <img src="https://ui-avatars.com/api/?name=<?php echo e(urlencode($partner->name)); ?>&background=0066ff&color=fff" alt="<?php echo e($partner->name); ?>">
                    </div>
                    <div class="partner-info">
                        <div class="partner-name"><?php echo e($partner->name); ?></div>
                        <div class="partner-role"><?php echo e($partner->major ?? '-'); ?></div>
                        <div class="partner-location"><?php echo e($partner->university ?? '-'); ?></div>
                    </div>
                    <div class="partner-match">
                        <div class="partner-match-value"><?php echo e($partner->match_percentage); ?>%</div>
                        <div class="partner-match-label">Match</div>
                    </div>
                </div>

                <?php
                    $teachSkills = $partner->userSkills->where('type', 'teach');
                    $learnSkills = $partner->userSkills->where('type', 'learn');
                ?>

                <?php if($teachSkills->count() > 0): ?>
                    <div class="partner-skills-section">
                        <div class="partner-skills-label teach">Bisa Mengajar</div>
                        <div class="partner-skill-tags">
                            <?php $__currentLoopData = $teachSkills; $__env->addLoop($__currentLoopData); foreach($__currentLoopData as $us): $__env->incrementLoopIndices(); $loop = $__env->getLastLoop(); ?>
                                <span class="partner-skill-tag teach"><?php echo e($us->skill->name); ?></span>
                            <?php endforeach; $__env->popLoop(); $loop = $__env->getLastLoop(); ?>
                        </div>
                    </div>
                <?php endif; ?>

                <?php if($learnSkills->count() > 0): ?>
                    <div class="partner-skills-section">
                        <div class="partner-skills-label learn">Ingin Belajar</div>
                        <div class="partner-skill-tags">
                            <?php $__currentLoopData = $learnSkills; $__env->addLoop($__currentLoopData); foreach($__currentLoopData as $us): $__env->incrementLoopIndices(); $loop = $__env->getLastLoop(); ?>
                                <span class="partner-skill-tag learn"><?php echo e($us->skill->name); ?></span>
                            <?php endforeach; $__env->popLoop(); $loop = $__env->getLastLoop(); ?>
                        </div>
                    </div>
                <?php endif; ?>

<div class="partner-actions" style="flex-direction: column;">
    <?php if(in_array($partner->id, $pendingRequestUserIds)): ?>
        <button class="btn btn-ghost" style="width: 100%; cursor: not-allowed;" disabled>
            ⏳ Menunggu Respon
        </button>
    <?php else: ?>
        <form method="POST" action="<?php echo e(url('/skill-exchange/' . $partner->id . '/request')); ?>" style="width: 100%;">
            <?php echo csrf_field(); ?>
            <textarea name="message" placeholder="Tulis pesan singkat, contoh: Mau buat aplikasi mobile, butuh partner Flutter." 
                style="width: 100%; padding: 10px; border: 1px solid var(--border-default); border-radius: var(--radius-md); font-family: var(--font-sans); font-size: 13px; resize: vertical; min-height: 60px; margin-bottom: var(--space-2);"></textarea>
            <button type="submit" class="btn btn-primary" style="width: 100%;">Kirim Request</button>
        </form>
    <?php endif; ?>
</div>
        <?php endforeach; $__env->popLoop(); $loop = $__env->getLastLoop(); if ($__empty_1): ?>
            <div class="empty-state">Belum ada partner yang cocok. Tambahkan skill kamu dulu di profil.</div>
        <?php endif; ?>
    </div>
</div>

<?php else: ?>
    <div class="section-card">
        <div class="section-header">
            <div class="section-title">Partner Saya</div>
        </div>

        <div class="partner-grid">
            <?php $__empty_1 = true; $__currentLoopData = $myPartners; $__env->addLoop($__currentLoopData); foreach($__currentLoopData as $partner): $__env->incrementLoopIndices(); $loop = $__env->getLastLoop(); $__empty_1 = false; ?>
                <div class="partner-card">
                    <div class="partner-header">
                        <div class="partner-avatar">
                            <img src="https://ui-avatars.com/api/?name=<?php echo e(urlencode($partner->name)); ?>&background=0066ff&color=fff" alt="<?php echo e($partner->name); ?>">
                        </div>
                        <div class="partner-info">
                            <div class="partner-name"><?php echo e($partner->name); ?></div>
                            <div class="partner-role"><?php echo e($partner->major ?? '-'); ?></div>
                            <div class="partner-location"><?php echo e($partner->university ?? '-'); ?></div>
                        </div>
                        <div class="partner-match">
                            <div class="partner-match-value"><?php echo e($partner->match_percentage); ?>%</div>
                            <div class="partner-match-label">Match</div>
                        </div>
                    </div>

                    <?php
                        $teachSkills = $partner->userSkills->where('type', 'teach');
                        $learnSkills = $partner->userSkills->where('type', 'learn');
                    ?>

                    <?php if($teachSkills->count() > 0): ?>
                        <div class="partner-skills-section">
                            <div class="partner-skills-label teach">Bisa Mengajar</div>
                            <div class="partner-skill-tags">
                                <?php $__currentLoopData = $teachSkills; $__env->addLoop($__currentLoopData); foreach($__currentLoopData as $us): $__env->incrementLoopIndices(); $loop = $__env->getLastLoop(); ?>
                                    <span class="partner-skill-tag teach"><?php echo e($us->skill->name); ?></span>
                                <?php endforeach; $__env->popLoop(); $loop = $__env->getLastLoop(); ?>
                            </div>
                        </div>
                    <?php endif; ?>

                    <?php if($learnSkills->count() > 0): ?>
                        <div class="partner-skills-section">
                            <div class="partner-skills-label learn">Ingin Belajar</div>
                            <div class="partner-skill-tags">
                                <?php $__currentLoopData = $learnSkills; $__env->addLoop($__currentLoopData); foreach($__currentLoopData as $us): $__env->incrementLoopIndices(); $loop = $__env->getLastLoop(); ?>
                                    <span class="partner-skill-tag learn"><?php echo e($us->skill->name); ?></span>
                                <?php endforeach; $__env->popLoop(); $loop = $__env->getLastLoop(); ?>
                            </div>
                        </div>
                    <?php endif; ?>
                </div>
            <?php endforeach; $__env->popLoop(); $loop = $__env->getLastLoop(); if ($__empty_1): ?>
                <div class="empty-state">Belum ada partner aktif. Terima partner request untuk mulai kolaborasi.</div>
            <?php endif; ?>
        </div>
    </div>
<?php endif; ?>

<?php $__env->stopSection(); ?>
<?php echo $__env->make('layouts.app', array_diff_key(get_defined_vars(), ['__data' => 1, '__path' => 1]))->render(); ?><?php /**PATH D:\laragon\www\Project_Final_Web_2\backend\resources\views/skill-exchange/index.blade.php ENDPATH**/ ?>