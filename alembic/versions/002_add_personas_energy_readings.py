"""Add personas and energy_readings tables

Revision ID: 002
Revises: 001
Create Date: 2025-12-16 12:00:00

"""
from alembic import op
import sqlalchemy as sa
from sqlalchemy.dialects import postgresql

# revision identifiers, used by Alembic
revision = '002'
down_revision = '001'
branch_labels = None
depends_on = None


def upgrade():
    """Upgrade to add personas and energy_readings tables."""
    
    # Update personas table with new columns
    # First, check if columns exist and add missing ones
    conn = op.get_bind()
    inspector = sa.inspect(conn)
    
    # Get existing columns
    existing_columns = {col['name'] for col in inspector.get_columns('personas')}
    
    # Add new columns if they don't exist
    if 'emoji' not in existing_columns:
        op.add_column('personas', sa.Column('emoji', sa.String(10), nullable=False, server_default='✨'))
    
    if 'archetype' not in existing_columns:
        op.add_column('personas', sa.Column('archetype', sa.String(50), nullable=False, server_default='custom'))
    
    if 'primary_energy' not in existing_columns:
        op.add_column('personas', sa.Column('primary_energy', sa.Text(), nullable=True))
    
    if 'strengths' not in existing_columns:
        op.add_column('personas', sa.Column('strengths', postgresql.ARRAY(sa.String()), nullable=True))
    
    if 'weaknesses' not in existing_columns:
        op.add_column('personas', sa.Column('weaknesses', postgresql.ARRAY(sa.String()), nullable=True))
    
    if 'trigger_conditions' not in existing_columns:
        op.add_column('personas', sa.Column('trigger_conditions', postgresql.ARRAY(sa.String()), nullable=True))
    
    if 'ideal_tasks' not in existing_columns:
        op.add_column('personas', sa.Column('ideal_tasks', postgresql.ARRAY(sa.String()), nullable=True))
    
    # Energy pattern times
    if 'peak_start_time' not in existing_columns:
        op.add_column('personas', sa.Column('peak_start_time', sa.String(5), nullable=True))
    
    if 'peak_end_time' not in existing_columns:
        op.add_column('personas', sa.Column('peak_end_time', sa.String(5), nullable=True))
    
    if 'trough_start_time' not in existing_columns:
        op.add_column('personas', sa.Column('trough_start_time', sa.String(5), nullable=True))
    
    if 'trough_end_time' not in existing_columns:
        op.add_column('personas', sa.Column('trough_end_time', sa.String(5), nullable=True))
    
    if 'recovery_start_time' not in existing_columns:
        op.add_column('personas', sa.Column('recovery_start_time', sa.String(5), nullable=True))
    
    if 'recovery_end_time' not in existing_columns:
        op.add_column('personas', sa.Column('recovery_end_time', sa.String(5), nullable=True))
    
    # Balance tracking
    if 'ideal_weekly_hours' not in existing_columns:
        op.add_column('personas', sa.Column('ideal_weekly_hours', sa.Float(), nullable=False, server_default='0.0'))
    
    if 'actual_weekly_hours' not in existing_columns:
        op.add_column('personas', sa.Column('actual_weekly_hours', sa.Float(), nullable=False, server_default='0.0'))
    
    if 'last_active' not in existing_columns:
        op.add_column('personas', sa.Column('last_active', sa.DateTime(), nullable=True))
    
    if 'is_active' not in existing_columns:
        op.add_column('personas', sa.Column('is_active', sa.Boolean(), nullable=False, server_default='true'))
    
    # Drop old columns that we're replacing
    if 'description' in existing_columns:
        op.drop_column('personas', 'description')
    
    if 'energy_patterns' in existing_columns:
        op.drop_column('personas', 'energy_patterns')
    
    if 'preferred_task_types' in existing_columns:
        op.drop_column('personas', 'preferred_task_types')
    
    if 'color_code' in existing_columns:
        op.drop_column('personas', 'color_code')
    
    if 'icon' in existing_columns:
        op.drop_column('personas', 'icon')
    
    # Create indexes for personas
    try:
        op.create_index('idx_personas_user_active', 'personas', ['user_id', 'is_active'])
    except:
        pass  # Index might already exist
    
    try:
        op.create_index('idx_personas_archetype', 'personas', ['archetype'])
    except:
        pass
    
    # Create energy_readings table
    op.create_table(
        'energy_readings',
        sa.Column('id', sa.String(32), primary_key=True),
        sa.Column('persona_id', sa.String(32), sa.ForeignKey('personas.id', ondelete='CASCADE'), nullable=False),
        sa.Column('timestamp', sa.DateTime(), nullable=False, server_default=sa.text('CURRENT_TIMESTAMP')),
        sa.Column('energy_level', sa.Integer(), nullable=False),
        sa.Column('confidence', sa.Float(), nullable=False, server_default='0.5'),
        sa.Column('source', sa.String(50), nullable=False, server_default='manual'),
        sa.Column('context', postgresql.JSONB(), nullable=True),
        sa.Column('notes', sa.Text(), nullable=True),
        sa.CheckConstraint('energy_level >= 1 AND energy_level <= 10', name='check_energy_level_range'),
        sa.CheckConstraint('confidence >= 0.0 AND confidence <= 1.0', name='check_energy_confidence_range'),
    )
    
    # Create indexes for energy_readings
    op.create_index('idx_energy_readings_persona_time', 'energy_readings', ['persona_id', 'timestamp'])
    op.create_index('idx_energy_readings_timestamp', 'energy_readings', ['timestamp'])


def downgrade():
    """Downgrade to remove personas and energy_readings enhancements."""
    
    # Drop energy_readings table
    op.drop_table('energy_readings')
    
    # Restore old persona columns
    op.add_column('personas', sa.Column('description', sa.Text(), nullable=True))
    op.add_column('personas', sa.Column('energy_patterns', postgresql.JSONB(), nullable=True))
    op.add_column('personas', sa.Column('preferred_task_types', postgresql.ARRAY(sa.String()), nullable=True))
    op.add_column('personas', sa.Column('color_code', sa.String(7), nullable=True))
    op.add_column('personas', sa.Column('icon', sa.String(50), nullable=True))
    
    # Drop new columns
    op.drop_column('personas', 'emoji')
    op.drop_column('personas', 'archetype')
    op.drop_column('personas', 'primary_energy')
    op.drop_column('personas', 'strengths')
    op.drop_column('personas', 'weaknesses')
    op.drop_column('personas', 'trigger_conditions')
    op.drop_column('personas', 'ideal_tasks')
    op.drop_column('personas', 'peak_start_time')
    op.drop_column('personas', 'peak_end_time')
    op.drop_column('personas', 'trough_start_time')
    op.drop_column('personas', 'trough_end_time')
    op.drop_column('personas', 'recovery_start_time')
    op.drop_column('personas', 'recovery_end_time')
    op.drop_column('personas', 'ideal_weekly_hours')
    op.drop_column('personas', 'actual_weekly_hours')
    op.drop_column('personas', 'last_active')
    op.drop_column('personas', 'is_active')
    
    # Drop indexes
    op.drop_index('idx_personas_user_active')
    op.drop_index('idx_personas_archetype')
