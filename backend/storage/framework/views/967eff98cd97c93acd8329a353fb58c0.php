

<?php $__env->startSection('title', $pageTitle . ' - NOERA'); ?>

<?php $__env->startSection('content'); ?>
<div class="page-header">
    <div class="page-header-content">
        <h1><?php echo e($pageTitle); ?></h1>
        <p>Temukan peluang terbaik yang sesuai dengan minat dan kebutuhanmu.</p>
    </div>
</div>

<form method="GET" action="<?php echo e(route('opportunities.index', $type)); ?>" class="search-bar-page">
    <input type="text" name="search" placeholder="Cari berdasarkan judul atau penyelenggara..." value="<?php echo e(request('search')); ?>">

    <?php if($availableTags->count()): ?>
        <select name="tag" onchange="this.form.submit()" class="opp-filter-select">
            <option value="">Semua Kategori</option>
            <?php $__currentLoopData = $availableTags; $__env->addLoop($__currentLoopData); foreach($__currentLoopData as $tagOption): $__env->incrementLoopIndices(); $loop = $__env->getLastLoop(); ?>
                <option value="<?php echo e($tagOption); ?>" <?php echo e(request('tag') == $tagOption ? 'selected' : ''); ?>>
                    <?php echo e($tagOption); ?>

                </option>
            <?php endforeach; $__env->popLoop(); $loop = $__env->getLastLoop(); ?>
        </select>
    <?php endif; ?>

    <button type="submit" class="btn btn-primary">Cari</button>
</form>

<div class="section-card">
    <div class="section-header">
        <div class="section-title">Semua <?php echo e($pageTitle); ?></div>
    </div>

    <div class="opp-grid">
        <?php $__empty_1 = true; $__currentLoopData = $opportunities; $__env->addLoop($__currentLoopData); foreach($__currentLoopData as $opp): $__env->incrementLoopIndices(); $loop = $__env->getLastLoop(); $__empty_1 = false; ?>
            <div class="opp-card">
                <div class="opp-card-header">
                    <span class="opp-tag opp-tag-<?php echo e($opp->type); ?>">
                        <?php echo e(ucfirst($opp->type)); ?>

                    </span>
                    <form method="POST" action="<?php echo e(route('opportunities.toggle-save', $opp->id)); ?>">
                        <?php echo csrf_field(); ?>
                        <button type="submit" class="opp-bookmark"
                            style="<?php echo e(in_array($opp->id, $savedIds) ? 'background: var(--primary-light); border-color: var(--primary); color: var(--primary);' : ''); ?>"
                            title="<?php echo e(in_array($opp->id, $savedIds) ? 'Batalkan simpan' : 'Simpan peluang'); ?>">
                            <svg fill="<?php echo e(in_array($opp->id, $savedIds) ? 'currentColor' : 'none'); ?>" stroke="currentColor" stroke-width="2" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" d="M5 5a2 2 0 012-2h10a2 2 0 012 2v16l-7-3.5L5 21V5z"/></svg>
                        </button>
                    </form>
                </div>
                <h3 class="opp-title"><?php echo e($opp->title); ?></h3>
                <div class="opp-org">
                    <svg fill="none" stroke="currentColor" stroke-width="2" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" d="M19 21V5a2 2 0 00-2-2H7a2 2 0 00-2 2v16m14 0h2m-2 0h-5m-9 0H3m2 0h5M9 7h1m-1 4h1m4-4h1m-1 4h1m-5 10v-5a1 1 0 011-1h2a1 1 0 011 1v5m-4 0h4"/></svg>
                    <?php echo e($opp->organizer); ?>

                </div>
                <div class="opp-tags">
                    <?php $__currentLoopData = $opp->tags; $__env->addLoop($__currentLoopData); foreach($__currentLoopData as $tag): $__env->incrementLoopIndices(); $loop = $__env->getLastLoop(); ?>
                        <span class="opp-tag-sm"><?php echo e($tag->tag); ?></span>
                    <?php endforeach; $__env->popLoop(); $loop = $__env->getLastLoop(); ?>
                </div>
                <div class="opp-meta">
                    <div class="opp-meta-item">
                        <label>Deadline</label>
                        <span class="deadline">
                            <?php echo e($opp->deadline ? \Carbon\Carbon::parse($opp->deadline)->translatedFormat('d M Y') : '-'); ?>

                        </span>
                    </div>
                    <div class="opp-meta-item">
                        <label>Benefit</label>
                        <span class="benefit"><?php echo e($opp->benefit ?? '-'); ?></span>
                    </div>
                </div>
                <?php if($opp->description): ?>
                    <p style="font-size: 13px; color: var(--gray-600); margin-bottom: var(--space-4); line-height: 1.5;">
                        <?php echo e(Str::limit($opp->description, 120)); ?>

                    </p>
                <?php endif; ?>
            </div>
        <?php endforeach; $__env->popLoop(); $loop = $__env->getLastLoop(); if ($__empty_1): ?>
            <div class="empty-state">Belum ada <?php echo e(strtolower($pageTitle)); ?> tersedia.</div>
        <?php endif; ?>
    </div>

    <?php if($opportunities->hasPages()): ?>
        <div class="opp-pagination">
            
            <?php if($opportunities->onFirstPage()): ?>
                <span class="opp-page-btn opp-page-disabled">&laquo; Sebelumnya</span>
            <?php else: ?>
                <a href="<?php echo e($opportunities->previousPageUrl()); ?>" class="opp-page-btn">&laquo; Sebelumnya</a>
            <?php endif; ?>

            
            <?php $__currentLoopData = range(1, $opportunities->lastPage()); $__env->addLoop($__currentLoopData); foreach($__currentLoopData as $page): $__env->incrementLoopIndices(); $loop = $__env->getLastLoop(); ?>
                <?php if($page == $opportunities->currentPage()): ?>
                    <span class="opp-page-btn opp-page-active"><?php echo e($page); ?></span>
                <?php else: ?>
                    <a href="<?php echo e($opportunities->url($page)); ?>" class="opp-page-btn"><?php echo e($page); ?></a>
                <?php endif; ?>
            <?php endforeach; $__env->popLoop(); $loop = $__env->getLastLoop(); ?>

            
            <?php if($opportunities->hasMorePages()): ?>
                <a href="<?php echo e($opportunities->nextPageUrl()); ?>" class="opp-page-btn">Selanjutnya &raquo;</a>
            <?php else: ?>
                <span class="opp-page-btn opp-page-disabled">Selanjutnya &raquo;</span>
            <?php endif; ?>
        </div>
    <?php endif; ?>
</div>
<?php $__env->stopSection(); ?>

<?php $__env->startPush('styles'); ?>
<style>
.opp-filter-select {
    padding: 10px 14px;
    border: 1px solid var(--gray-300, #d1d5db);
    border-radius: 8px;
    font-size: 14px;
    background: white;
    color: var(--gray-700, #374151);
    margin: 0 8px;
}

.opp-pagination {
    display: flex;
    justify-content: center;
    align-items: center;
    gap: 6px;
    margin-top: var(--space-6, 24px);
    flex-wrap: wrap;
}

.opp-page-btn {
    padding: 8px 14px;
    border: 1px solid var(--gray-300, #d1d5db);
    border-radius: 8px;
    font-size: 14px;
    color: var(--gray-700, #374151);
    text-decoration: none;
    transition: all 0.15s ease;
}

.opp-page-btn:hover {
    background: var(--primary-light, #eff6ff);
    border-color: var(--primary, #2563eb);
    color: var(--primary, #2563eb);
}

.opp-page-active {
    background: var(--primary, #2563eb);
    border-color: var(--primary, #2563eb);
    color: white;
    font-weight: 600;
}

.opp-page-disabled {
    opacity: 0.4;
    cursor: not-allowed;
    pointer-events: none;
}
</style>
<?php $__env->stopPush(); ?>

<?php echo $__env->make('layouts.app', array_diff_key(get_defined_vars(), ['__data' => 1, '__path' => 1]))->render(); ?><?php /**PATH D:\laragon\www\Project_Final_Web_2\backend\resources\views/opportunities/index.blade.php ENDPATH**/ ?>