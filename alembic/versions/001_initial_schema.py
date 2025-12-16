"""Initial schema with users, contexts, personas, tasks

Revision ID: 001
Revises: 
Create Date: 2025-12-16 09:54:00

"""
from alembic import op
import sqlalchemy as sa
from sqlalchemy.dialects import postgresql

# revision identifiers, used by Alembic.
revision = '001'
down_revision = None
branch_labels = None
depends_on = None


def upgrade() -> None:
    # Create users table
    op.create_table('users',
        sa.Column('id', sa.String(length=32), nullable=False),
        sa.Column('email', sa.String(length=255), nullable=True),
        sa.Column('display_name', sa.String(length=100), nullable=True),
        sa.Column('passphrase_hash', sa.String(length=255), nullable=True),
        sa.Column('created_at', sa.DateTime(), nullable=False),
        sa.Column('last_login', sa.DateTime(), nullable=True),
        sa.Column('is_active', sa.Boolean(), nullable=False),
        sa.PrimaryKeyConstraint('id'),
        sa.UniqueConstraint('email')
    )
    
    # Create personas table
    op.create_table('personas',
        sa.Column('id', sa.String(length=32), nullable=False),
        sa.Column('user_id', sa.String(length=32), nullable=False),
        sa.Column('name', sa.String(length=100), nullable=False),
        sa.Column('description', sa.Text(), nullable=True),
        sa.Column('energy_patterns', postgresql.JSONB(astext_type=sa.Text()), nullable=True),
        sa.Column('preferred_task_types', postgresql.ARRAY(sa.String()), nullable=True),
        sa.Column('color_code', sa.String(length=7), nullable=True),
        sa.Column('icon', sa.String(length=50), nullable=True),
        sa.Column('created_at', sa.DateTime(), nullable=False),
        sa.Column('updated_at', sa.DateTime(), nullable=False),
        sa.ForeignKeyConstraint(['user_id'], ['users.id'], ondelete='CASCADE'),
        sa.PrimaryKeyConstraint('id')
    )
    
    # Create user_contexts table
    op.create_table('user_contexts',
        sa.Column('id', sa.String(length=32), nullable=False),
        sa.Column('user_id', sa.String(length=32), nullable=False),
        sa.Column('context_type', sa.String(length=50), nullable=False),
        sa.Column('key', sa.String(length=100), nullable=False),
        sa.Column('value', postgresql.JSONB(astext_type=sa.Text()), nullable=False),
        sa.Column('confidence', sa.Float(), nullable=False),
        sa.Column('weight', sa.Float(), nullable=False),
        sa.Column('learned_from', sa.String(length=100), nullable=False),
        sa.Column('created_at', sa.DateTime(), nullable=False),
        sa.Column('updated_at', sa.DateTime(), nullable=False),
        sa.Column('last_accessed', sa.DateTime(), nullable=False),
        sa.CheckConstraint('confidence >= 0 AND confidence <= 1', name='check_confidence_range'),
        sa.CheckConstraint('weight >= 0 AND weight <= 1', name='check_weight_range'),
        sa.ForeignKeyConstraint(['user_id'], ['users.id'], ondelete='CASCADE'),
        sa.PrimaryKeyConstraint('id')
    )
    op.create_index('idx_user_contexts_created', 'user_contexts', ['created_at'], unique=False)
    op.create_index('idx_user_contexts_unique', 'user_contexts', ['user_id', 'context_type', 'key'], unique=True)
    op.create_index('idx_user_contexts_user_type', 'user_contexts', ['user_id', 'context_type'], unique=False)
    op.create_index('idx_user_contexts_weight', 'user_contexts', ['weight'], unique=False)
    
    # Create user_feedback table
    op.create_table('user_feedback',
        sa.Column('id', sa.String(length=32), nullable=False),
        sa.Column('user_id', sa.String(length=32), nullable=False),
        sa.Column('interaction_type', sa.String(length=50), nullable=False),
        sa.Column('interaction_data', postgresql.JSONB(astext_type=sa.Text()), nullable=False),
        sa.Column('feedback_type', sa.String(length=50), nullable=False),
        sa.Column('feedback_data', postgresql.JSONB(astext_type=sa.Text()), nullable=False),
        sa.Column('created_at', sa.DateTime(), nullable=False),
        sa.ForeignKeyConstraint(['user_id'], ['users.id'], ondelete='CASCADE'),
        sa.PrimaryKeyConstraint('id')
    )
    op.create_index('idx_feedback_type', 'user_feedback', ['interaction_type'], unique=False)
    op.create_index('idx_feedback_user_time', 'user_feedback', ['user_id', 'created_at'], unique=False)
    
    # Create tasks table
    op.create_table('tasks',
        sa.Column('id', sa.String(length=32), nullable=False),
        sa.Column('user_id', sa.String(length=32), nullable=False),
        sa.Column('persona_id', sa.String(length=32), nullable=True),
        sa.Column('title', sa.String(length=500), nullable=False),
        sa.Column('description', sa.Text(), nullable=True),
        sa.Column('priority', sa.Integer(), nullable=True),
        sa.Column('energy_required', sa.Integer(), nullable=True),
        sa.Column('estimated_duration', sa.Integer(), nullable=True),
        sa.Column('due_date', sa.DateTime(), nullable=True),
        sa.Column('completed', sa.Boolean(), nullable=False),
        sa.Column('completed_at', sa.DateTime(), nullable=True),
        sa.Column('source', sa.String(length=50), nullable=True),
        sa.Column('source_metadata', postgresql.JSONB(astext_type=sa.Text()), nullable=True),
        sa.Column('created_at', sa.DateTime(), nullable=False),
        sa.CheckConstraint('energy_required >= 1 AND energy_required <= 5', name='check_energy_range'),
        sa.CheckConstraint('priority >= 1 AND priority <= 5', name='check_priority_range'),
        sa.ForeignKeyConstraint(['persona_id'], ['personas.id'], ondelete='SET NULL'),
        sa.ForeignKeyConstraint(['user_id'], ['users.id'], ondelete='CASCADE'),
        sa.PrimaryKeyConstraint('id')
    )
    op.create_index('idx_tasks_due_date', 'tasks', ['due_date'], unique=False)
    op.create_index('idx_tasks_user_completed', 'tasks', ['user_id', 'completed'], unique=False)
    
    # Create insights table
    op.create_table('insights',
        sa.Column('id', sa.String(length=32), nullable=False),
        sa.Column('user_id', sa.String(length=32), nullable=False),
        sa.Column('persona_id', sa.String(length=32), nullable=True),
        sa.Column('type', sa.String(length=50), nullable=False),
        sa.Column('content', sa.Text(), nullable=False),
        sa.Column('confidence', sa.Float(), nullable=False),
        sa.Column('dismissed', sa.Boolean(), nullable=False),
        sa.Column('created_at', sa.DateTime(), nullable=False),
        sa.CheckConstraint('confidence >= 0 AND confidence <= 1', name='check_insight_confidence'),
        sa.ForeignKeyConstraint(['persona_id'], ['personas.id'], ondelete='SET NULL'),
        sa.ForeignKeyConstraint(['user_id'], ['users.id'], ondelete='CASCADE'),
        sa.PrimaryKeyConstraint('id')
    )
    op.create_index('idx_insights_user_dismissed', 'insights', ['user_id', 'dismissed'], unique=False)


def downgrade() -> None:
    op.drop_index('idx_insights_user_dismissed', table_name='insights')
    op.drop_table('insights')
    op.drop_index('idx_tasks_user_completed', table_name='tasks')
    op.drop_index('idx_tasks_due_date', table_name='tasks')
    op.drop_table('tasks')
    op.drop_index('idx_feedback_user_time', table_name='user_feedback')
    op.drop_index('idx_feedback_type', table_name='user_feedback')
    op.drop_table('user_feedback')
    op.drop_index('idx_user_contexts_weight', table_name='user_contexts')
    op.drop_index('idx_user_contexts_user_type', table_name='user_contexts')
    op.drop_index('idx_user_contexts_unique', table_name='user_contexts')
    op.drop_index('idx_user_contexts_created', table_name='user_contexts')
    op.drop_table('user_contexts')
    op.drop_table('personas')
    op.drop_table('users')
