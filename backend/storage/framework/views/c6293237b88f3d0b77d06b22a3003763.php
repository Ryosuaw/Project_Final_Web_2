

<?php $__env->startSection('title', 'Study Club - NOERA'); ?>

<?php $__env->startSection('content'); ?>
<div class="page-header">
    <div class="page-header-content">
        <h1>Study Club</h1>
        <p>Gabung grup belajar dan tukar ilmu mingguan bareng mentor mahasiswa.</p>
    </div>
</div>

<form method="GET" action="<?php echo e(route('study-club.index')); ?>" class="search-bar-page">
    <input type="text" name="search" placeholder="Cari nama grup..." value="<?php echo e(request('search')); ?>">
    <button type="submit" class="btn btn-primary">Cari</button>
</form>

<div class="section-card">
    <div class="section-header">
        <div class="section-title">Buat Study Club Baru</div>
    </div>
    <form method="POST" action="<?php echo e(route('study-club.store')); ?>" class="study-club-form">
        <?php echo csrf_field(); ?>
        <input type="text" name="name" placeholder="Nama grup belajar..." required>
        <textarea name="description" placeholder="Deskripsi singkat (opsional)..." rows="2"></textarea>
        <button type="submit" class="btn btn-primary">Buat Grup</button>
    </form>
</div>

<div class="section-card">
    <div class="section-header">
        <div class="section-title">Semua Study Club</div>
    </div>

    <div class="opp-grid">
        <?php $__empty_1 = true; $__currentLoopData = $studyClubs; $__env->addLoop($__currentLoopData); foreach($__currentLoopData as $club): $__env->incrementLoopIndices(); $loop = $__env->getLastLoop(); $__empty_1 = false; ?>
            <div class="opp-card">
                <h3 class="opp-title"><?php echo e($club->name); ?></h3>
                <div class="opp-org">
                    <svg fill="none" stroke="currentColor" stroke-width="2" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" d="M17 20h5v-2a4 4 0 00-3-3.87M9 20H4v-2a4 4 0 013-3.87m6-1.13a4 4 0 10-4-4 4 4 0 004 4zm6 0a4 4 0 10-4-4"/></svg>
                    Dibuat oleh <?php echo e($club->creator->name ?? '-'); ?>

                </div>

                <?php if($club->description): ?>
                    <p style="font-size: 13px; color: var(--gray-600); margin: var(--space-2) 0 var(--space-4); line-height: 1.5;">
                        <?php echo e(Str::limit($club->description, 120)); ?>

                    </p>
                <?php endif; ?>

                <div class="opp-meta">
                    <div class="opp-meta-item">
                        <label>Anggota</label>
                        <span class="benefit"><?php echo e($club->members_count); ?> orang</span>
                    </div>
                </div>

                <?php if(in_array($club->id, $joinedIds)): ?>
                    <form method="POST" action="<?php echo e(route('study-club.leave', $club->id)); ?>" style="margin-top: var(--space-4);">
                        <?php echo csrf_field(); ?>
                        <button type="submit" class="btn btn-outline" style="width: 100%;">Keluar dari Grup</button>
                    </form>
                <?php else: ?>
                    <form method="POST" action="<?php echo e(route('study-club.join', $club->id)); ?>" style="margin-top: var(--space-4);">
                        <?php echo csrf_field(); ?>
                        <button type="submit" class="btn btn-primary" style="width: 100%;">Gabung Grup</button>
                    </form>
                <?php endif; ?>
            </div>
        <?php endforeach; $__env->popLoop(); $loop = $__env->getLastLoop(); if ($__empty_1): ?>
            <div class="empty-state">Belum ada study club tersedia. Yuk buat yang pertama!</div>
        <?php endif; ?>
    </div>

    <?php if($studyClubs->hasPages()): ?>
        <div class="opp-pagination">
            <?php if($studyClubs->onFirstPage()): ?>
                <span class="opp-page-btn opp-page-disabled">&laquo; Sebelumnya</span>
            <?php else: ?>
                <a href="<?php echo e($studyClubs->previousPageUrl()); ?>" class="opp-page-btn">&laquo; Sebelumnya</a>
            <?php endif; ?>

            <?php $__currentLoopData = range(1, $studyClubs->lastPage()); $__env->addLoop($__currentLoopData); foreach($__currentLoopData as $page): $__env->incrementLoopIndices(); $loop = $__env->getLastLoop(); ?>
                <?php if($page == $studyClubs->currentPage()): ?>
                    <span class="opp-page-btn opp-page-active"><?php echo e($page); ?></span>
                <?php else: ?>
                    <a href="<?php echo e($studyClubs->url($page)); ?>" class="opp-page-btn"><?php echo e($page); ?></a>
                <?php endif; ?>
            <?php endforeach; $__env->popLoop(); $loop = $__env->getLastLoop(); ?>

            <?php if($studyClubs->hasMorePages()): ?>
                <a href="<?php echo e($studyClubs->nextPageUrl()); ?>" class="opp-page-btn">Selanjutnya &raquo;</a>
            <?php else: ?>
                <span class="opp-page-btn opp-page-disabled">Selanjutnya &raquo;</span>
            <?php endif; ?>
        </div>
    <?php endif; ?>
</div>
<?php $__env->stopSection(); ?>

<?php $__env->startPush('styles'); ?>
<style>
.study-club-form {
    display: flex;
    flex-direction: column;
    gap: 12px;
    padding: 0 var(--space-4, 16px) var(--space-4, 16px);
}

.study-club-form input,
.study-club-form textarea {
    padding: 10px 14px;
    border: 1px solid var(--gray-300, #d1d5db);
    border-radius: 8px;
    font-size: 14px;
    font-family: inherit;
    resize: vertical;
}

.btn-outline {
    background: white;
    border: 1px solid var(--gray-300, #d1d5db);
    color: var(--gray-700, #374151);
    padding: 10px;
    border-radius: 8px;
    cursor: pointer;
}

.btn-outline:hover {
    background: var(--gray-50, #f9fafb);
}
</style>
<?php $__env->stopPush(); ?>
<?php echo $__env->make('layouts.app', array_diff_key(get_defined_vars(), ['__data' => 1, '__path' => 1]))->render(); ?><?php /**PATH D:\laragon\www\Project_Final_Web_2\resources\views/study-club/index.blade.php ENDPATH**/ ?>